sample1=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=1&per_page=100")
count1=$(echo $sample1 | jq '.[].user.login' 2>/dev/null | grep -cs $1)
sample2=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=2&per_page=100")
count2=$(echo $sample2 | jq '.[].user.login' 2>/dev/null | grep -cs $1)
sample3=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls?state=all&page=3&per_page=100")
count3=$(echo $sample3 | jq '.[].user.login' 2>/dev/null | grep -cs $1)
count=$(($count1+$count2+$count3))
echo "PULLS $count"

LOGIN="\"$1\""
id1=$(echo $sample1 | jq -c '.[] | select(.user.login=='$LOGIN')' 2>/dev/null | jq '.number' | tail -1)
id2=$(echo $sample2 | jq -c '.[] | select(.user.login=='$LOGIN')' 2>/dev/null | jq '.number' | tail -1)
id3=$(echo $sample3 | jq -c '.[] | select(.user.login=='$LOGIN')' 2>/dev/null | jq '.number' | tail -1)

if [ -z "$id3" ]
then
  if [ -z "$id2" ]
  then
    id=id1
  else
    id=id2
  fi
 else
  id=id3
fi
echo "EARLIEST $id"

merge_status=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls/$id" | jq '.merged_at')
if [[ "$merge_status" == "null" ]]
then
echo "MERGED 1"
else
echo "MERGED 0"
fi
