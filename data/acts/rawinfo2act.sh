#!/bin/bash

# parameters
PWD=`pwd`
INF=$PWD/$1
TMP=$PWD/$1.tmp
ACT=$PWD/$2

# detect parameters
if [ -z "$2" ]; then
    echo "Usage: ./info_txt2csv.sh [/path/to/file.txt] [/path/to/file.csv]"
    echo ".csv will be generated based on .txt"
    exit
fi

# example
#
#   title = 蝙蝠俠：開戰時刻
#   主要演員：克里斯多福諾蘭
#   title = 蝙蝠俠：開戰時刻
#   克里斯汀貝爾
#   title = 蝙蝠俠：開戰時刻
#   米高肯恩
#   title = 蝙蝠俠：開戰時刻
#   蓋瑞歐德曼
#   title = 蝙蝠俠：開戰時刻
#   凱蒂荷姆絲
#   title = 蝙蝠俠：開戰時刻
#   摩根費里曼
#   title = 蝙蝠俠：開戰時刻
#   連恩尼遜
# ->
#   蝙蝠俠：開戰時刻,克里斯多福諾蘭
#   蝙蝠俠：開戰時刻,克里斯汀貝爾
#   蝙蝠俠：開戰時刻,米高肯恩
#   蝙蝠俠：開戰時刻,蓋瑞歐德曼
#   蝙蝠俠：開戰時刻,凱蒂荷姆絲
#   蝙蝠俠：開戰時刻,摩根費里曼
#   蝙蝠俠：開戰時刻,連恩尼遜

# generate a temp csv
cp $INF $TMP

# remove unnessarys
`sed -i '' 's/\s//g' $TMP`
`sed -i '' '1 s/title=//g' $TMP`
`sed -i '' '/EN_title/ d' $TMP`
`sed -i '' '/intro/ d' $TMP`
`sed -i '' '/影片類型/ d' $TMP`
`sed -i '' 's/主要演員：//g' $TMP`
`sed -i '' '/---/ d' $TMP`
`sed -i '' 's/\.//g' $TMP`

# fix
`sed -i '' -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' $TMP`
`sed -i '' 's/,title=/\'$'\n/g' $TMP`

# generate csv file and add attribute name to first line
`touch $ACT`
`echo "movie,actor" > $ACT`
`cat $TMP >> $ACT`
rm $TMP
