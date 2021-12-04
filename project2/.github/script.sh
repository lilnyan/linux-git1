formats=`find . -type f -not -path '*/\.git/*' | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`
values=''
total=0
for i in $formats
do
files=`find . -type f -name "*.$i"`
count=0
for j in $files
do
count="$(($count+`cat $j | wc -m`))"
done
total="$(($total+$count))"
echo $i $count
done
echo $total

