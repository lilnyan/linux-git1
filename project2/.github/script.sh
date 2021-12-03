formats=`find . -type f -not -path '*/\.git/*' | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`
for i in $formats
do
files=`find . -type f -name "*.$i"`
count=0
for j in $files
do
count=$count+`wc -m $j`
done
echo $i $count
done
