formats=`find . -type f -not -path '*/\.git/*' | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`
total_count=$(wc -m `find . -type f -not -path '*/\.git/*'` | tail -1 | sed 's/ total.*//' | bc)
for i in $formats
do
files=`find . -type f -name "*.$i"`
count=0
for j in $files
do
count="$(($count+`cat $j | wc -m`))"
done
count=`jq -n $count*100/$total_count`
count=`echo "scale=4; $count/1" | bc`
echo $i $count"%"
done
last_count=$(wc -m `find . -type f ! -name "*.*" -not -path '*/\.git/*'` | tail -1 | sed 's/ total.*//' | bc)
last_count=`jq -n $last_count*100/$total_count`
last_count=`echo "scale=4; $last_count/1" | bc`
echo "without extension" $last_count"%"
