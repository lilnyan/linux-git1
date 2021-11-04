#!/bin/sh
echo "Subject| Status |        max  |       min  |      mean  |    std" > stats.txt
for i in $(ls EEG_Dataset); do
  export MIN=$(awk -F "," 'BEGIN{a=0}{if ($2<0+a) a=$2} END{print a}' EEG_Dataset/${i} | tr -d \n)
  export MAX=$(awk -F "," 'BEGIN{a=0}{if ($2>0+a) a=$2} END{print a}' EEG_Dataset/${i} | tr -d "\n")
  export MEAN=$(awk -F "," '{print $0}' EEG_Dataset/$i | awk -F, 'BEGIN{x=0} {x+=$2} END{print x/NR-1}')
  export STD=$(awk -F "," '{print $0}' EEG_Dataset/$i | awk -F "," '{delta = $2 - avg; avg += delta / NR; mean2 += delta * ($2 - avg); } END { print sqrt(mean2 / NR); }')
  echo ${i:8:1},${i:10:1},$MIN >> stats.txt
  echo $MAX,$MEAN,$STD >> stats.txt
done
cat stats.txt
pip install -q -r requirements.txt
python3 processing.py
