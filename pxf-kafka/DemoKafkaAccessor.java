package org.apache.hawq.pxf.api.examples;

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import org.apache.hawq.pxf.api.OneRow;
import org.apache.hawq.pxf.api.ReadAccessor;
import org.apache.hawq.pxf.api.utilities.InputData;
import org.apache.hawq.pxf.api.utilities.Plugin;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.errors.WakeupException;
import org.apache.kafka.common.serialization.StringDeserializer;

import java.util.*;

/**
 * Internal interface that would defined the access to a file on HDFS, but in
 * this case contains the data required.
 *
 * Dummy implementation
 */
public class DemoKafkaAccessor extends Plugin implements ReadAccessor {
    private static final Log LOG = LogFactory.getLog(DemoKafkaAccessor.class);
    private int rowNumber;
    private int fragmentNumber;
    private static int POLL_TIMEOUT = 1000;
    private KafkaConsumer<String, String> consumer;
    private int recordsRead;

    /**
     * Constructs a DemoKafkaAccessor
     *
     * @param metaData
     */
    public DemoKafkaAccessor(InputData metaData) {
        super(metaData);
    }
    @Override
    public boolean openForRead() throws Exception {

        Properties props = new Properties();
        String[] tokens = inputData.getDataSource().split("\\|");
        if (tokens.length < 3)
            throw new RuntimeException("Table definition should have table name|Kafka host|Kafka topic name");
        props.put("bootstrap.servers", tokens[1] + ":9092");
        props.put(ConsumerConfig.GROUP_ID_CONFIG, UUID.randomUUID().toString()); /* consumer group*/
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        props.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, Integer.MAX_VALUE);
        this.consumer = new KafkaConsumer<>(props);
        consumer.subscribe(Arrays.asList(tokens[2]));

        return true;
    }
    @Override
    public OneRow readNextObject() throws Exception {

        OneRow row;
        try {
                StringBuilder lines = new StringBuilder();
                ConsumerRecords<String, String> records = consumer.poll(POLL_TIMEOUT);
                for (ConsumerRecord<String, String> record : records) {
                    if(recordsRead > 0) {
                        lines.append('\n');
                    }
                    lines.append(record.value());
                    recordsRead++;
                }
                row = new OneRow(null, lines.toString());
                return row;
        } catch (WakeupException e) {
            LOG.error("Error reading kakfa stream");
        }
        return null;
    }
    @Override
    public void closeForRead() throws Exception {
        consumer.close();
    }
}
