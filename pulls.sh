LOGIN="\"$1\""
count=0
for i in 1 2 3 4
do
c=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls?state=all&per_page=100&page=$i"| jq '.[].user.login' 2>/dev/null | grep -cs $1)
count=$(($count+$c))
done
echo "PULLS $count"

id=""
for i in 4 3 2 1
do
if [ -z "$id" ]
then
id=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls?state=all&per_page=100&page=$i" | jq -c '.[] | select(.user.login=='$LOGIN')' 2>/dev/null | jq '.number' | tail -1)
fi
done
echo "EARLIEST $id"


merge_status=$(curl -s "https://api.github.com/repos/datamove/linux-git2/pulls/$id" | jq '.merged_at')
if [ "$merge_status" == "null" ]
then
echo "MERGED 0"
else
echo "MERGED 1"
fi
