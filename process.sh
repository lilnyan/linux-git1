#!/bin/sh
echo "Subject| Status |        max  |       min  |      mean  |    std"
for i in $(ls EEG_Dataset); do
  echo "${i:8:1}   ${i:10:1}"
  echo "$(cat EEG_Dataset/${i} | awk -F "," 'NR>1 {print $2}' | sort -nr | head -n1)"
  echo "$(cat EEG_Dataset/${i} | awk -F "," 'NR>1 {print $2}' | sort -nr | tail -n1)"
  export MEAN=$(awk -F "," '{print $0}' EEG_Dataset/$i | awk -F, 'BEGIN{x=0} {x+=$2} END{print x/NR-1}')
  export STD=$(awk -F "," '{print $0}' EEG_Dataset/$i | awk -F "," '{delta = $2 - avg; avg += delta / NR; mean2 += delta * ($2 - avg); } END { print sqrt(mean2 / NR); }')
  echo "  $MEAN    $STD"
done

python3 processing.py
