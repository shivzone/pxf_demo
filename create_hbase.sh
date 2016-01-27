#################
#
# HBase table representing products:
#
# product_id (integer) - row id
# product_name (text)
# category (text)
# price (integer)
#
################

# 1. create HBase table
hbase shell <<EOF

disable 'products'
drop 'products'
create 'products', 'product', 'category'
EOF

# 2. populate fields 

hbase shell <<EOF
put 'products', '1', 'category:name', 'Club'
put 'products', '1', 'product:name', 'Ronaldo'
put 'products', '1', 'product:price', '80'
put 'products', '2', 'category:name', 'Country'
put 'products', '2', 'product:name', 'Ronaldo'
put 'products', '2', 'product:price', '70'
put 'products', '3', 'category:name', 'Club'
put 'products', '3', 'product:name', 'Messi'
put 'products', '3', 'product:price', '90'
put 'products', '4', 'category:name', 'Country'
put 'products', '4', 'product:name', 'Messi'
put 'products', '4', 'product:price', '99'
put 'products', '5', 'category:name', 'Club'
put 'products', '5', 'product:name', 'Robben'
put 'products', '5', 'product:price', '110'
put 'products', '6', 'category:name', 'Country'
put 'products', '6', 'product:name', 'Robben'
put 'products', '6', 'product:price', '90'
put 'products', '7', 'category:name', 'Club'
put 'products', '7', 'product:name', 'Rooney'
put 'products', '7', 'product:price', '90'
put 'products', '8', 'category:name', 'Country'
put 'products', '8', 'product:name', 'Rooney'
put 'products', '8', 'product:price', '40'
put 'products', '9', 'category:name', 'Club'
put 'products', '9', 'product:name', 'Lewandowski'
put 'products', '9', 'product:price', '100'
put 'products', '10', 'category:name', 'Club'
put 'products', '10', 'product:name', 'Neymar'
put 'products', '10', 'product:price', '100'
put 'products', '11', 'category:name', 'Country'
put 'products', '11', 'product:name', 'Neymar'
put 'products', '11', 'product:price', '60'
put 'products', '12', 'category:name', 'Club'
put 'products', '12', 'product:name', 'Alexis'
put 'products', '12', 'product:price', '92'
put 'products', '13', 'category:name', 'Club'
put 'products', '13', 'product:name', 'James'
put 'products', '13', 'product:price', '85'
put 'products', '14', 'category:name', 'Country'
put 'products', '14', 'product:name', 'James'
put 'products', '14', 'product:price', '90'
put 'products', '15', 'category:name', 'Club'
put 'products', '15', 'product:name', 'Bale'
put 'products', '15', 'product:price', '85'
put 'products', '16', 'category:name', 'Club'
put 'products', '16', 'product:name', 'Pogba'
put 'products', '16', 'product:price', '100'
put 'products', '17', 'category:name', 'Country'
put 'products', '17', 'product:name', 'Pogba'
put 'products', '17', 'product:price', '90'
put 'products', '18', 'category:name', 'Country'
put 'products', '18', 'product:name', 'Morgan'
put 'products', '18', 'product:price', '68'
put 'products', '19', 'category:name', 'Club'
put 'products', '19', 'product:name', 'Hazard'
put 'products', '19', 'product:price', '90'
put 'products', '20', 'category:name', 'Country'
put 'products', '20', 'product:name', 'Hazard'
put 'products', '20', 'product:price', '90'
put 'products', '21', 'category:name', 'Club'
put 'products', '21', 'product:name', 'Ibrahimovic'
put 'products', '21', 'product:price', '100'
put 'products', '22', 'category:name', 'Country'
put 'products', '22', 'product:name', 'Ibrahimovic'
put 'products', '22', 'product:price', '90'
put 'products', '23', 'category:name', 'Club'
put 'products', '23', 'product:name', 'De Bruyne'
put 'products', '23', 'product:price', '100'
put 'products', '24', 'category:name', 'Country'
put 'products', '24', 'product:name', 'De Bruyne'
put 'products', '24', 'product:price', '90'
put 'products', '25', 'category:name', 'Club'
put 'products', '25', 'product:name', 'Willian'
put 'products', '25', 'product:price', '80'
put 'products', '26', 'category:name', 'Country'
put 'products', '26', 'product:name', 'Willian'
put 'products', '26', 'product:price', '40'
put 'products', '27', 'category:name', 'Country'
put 'products', '27', 'product:name', 'Wambach'
put 'products', '27', 'product:price', '68'
put 'products', '28', 'category:name', 'Country'
put 'products', '28', 'product:name', 'Lloyd'
put 'products', '28', 'product:price', '160'
put 'products', '29', 'category:name', 'Club'
put 'products', '29', 'product:name', 'Coutinho'
put 'products', '29', 'product:price', '88'
put 'products', '30', 'category:name', 'Country'
put 'products', '30', 'product:name', 'Coutinho'
put 'products', '30', 'product:price', '40'
EOF

# 3. show results
hbase shell <<EOF

scan 'products'
EOF
