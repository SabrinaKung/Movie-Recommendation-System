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
#   EN_title = BATMAN BEGINS
#   intro = 克里斯多夫諾蘭  經典作品 ...
#   主要演員：克里斯多福諾蘭,克里斯汀貝爾,米高肯恩,蓋瑞歐德曼,凱蒂荷姆絲,摩根費里曼,連恩尼遜
#   影片類型：動作
# ->
#   克里斯多福諾蘭,,,
#   克里斯汀貝爾,,,
#   米高肯恩,,,
#   蓋瑞歐德曼,,,
#   凱蒂荷姆絲,,,
#   摩根費里曼,,,
#   連恩尼遜,,,

# generate a temp csv
cp $INF $TMP

# remove unnessarys
`sed -i "" 's/\s//g' $TMP`
`sed -i "" '/title/ d' $TMP`
`sed -i "" '/EN_title/ d' $TMP`
`sed -i "" '/intro/ d' $TMP`
`sed -i "" 's/影片類型.*/,/g' $TMP`
`sed -i "" 's/主要演員：//g' $TMP`
`sed -i "" '/---/ d' $TMP`
`sed -i "" 's/\.//g' $TMP`

# fix
`sed -i "" ':a;N;$!ba; s/\n/g' $TMP`
`sed -i "" 's/,\+/,/g' $TMP`
`sed -i "" 's/,/,,,\n/g' $TMP`
`sed -i "" '$ d' $TMP`

# generate csv file and add attribute name to first line
`touch $ACT`
`echo "name,SSN,sex,birth" > $ACT`
`cat $TMP >> $ACT`
# sort and uniq
#`sort $TMP | uniq >> $ACT`
rm $TMP
