#!/bin/bash
echo "Subject, Status, max, min, mean, std" >> stats1.csv
for i in $(ls EEG_Dataset); do
  echo "${i:0:7} №${i:8:1}"
  awk 
  printf "Status: "
if [ ${i:10:1} -eq 0 ]; 
   then 
    echo "Not interested" 
   else 
    echo "Interested" 
  fi
 printf "max value:  "
 cat EEG_Dataset/${i} | awk -F "," 'NR>1 {print $2}' | sort -nr | head -n1
 printf "min value:  "
 cat EEG_Dataset/${i} | awk -F "," 'NR>1 {print $2}' | sort -nr | tail -n1

done
