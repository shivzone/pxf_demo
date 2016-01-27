# format: transaction_id,product_id,customer_id,day

rm transactions.csv

for i in {1..200} ; do echo "$i,$((RANDOM%30 + 1)),$((RANDOM%400 + 1)),2015-03-0$((RANDOM%9 + 1))" >> transactions.csv; done
for i in {201..400} ; do echo "$i,$((RANDOM%30 + 1)),$((RANDOM%400 + 1)),2015-03-1$((RANDOM%10))" >> transactions.csv; done
for i in {401..600} ; do echo "$i,$((RANDOM%30 + 1)),$((RANDOM%400 + 1)),2015-03-2$((RANDOM%10))" >> transactions.csv; done
for i in {601..700} ; do echo "$i,$((RANDOM%30 + 1)),$((RANDOM%400 + 1)),2015-03-3$((RANDOM%2))" >> transactions.csv; done

#for i in {1..100} ; do echo "$i,$((i*30)),$((i%400)),2015-04-1$((i%10))" >> transactions.csv; done

#for i in {1..100} ; do echo "$i,$((i*30)),$((i%400)),2015-04-2$((i%10))" >> transactions.csv; done

#for i in {1..100} ; do echo "$i,$((i*30)),$((i%400)),2015-04-3$((i%2))" >> transactions.csv; done
