#!/bin/zsh

TXT=$1
TMP=tmp_$1
CSV=$2

# detect parameters
if [ -z "$2" ]; then
    echo "Usage: ./txt2csv txtfile.txt csvfile.csv"
    echo "csvfile.csv will be generated based on txtfile.txt"
    exit
fi

# example
#
#   title = 國賓電影網站入口 - 國賓影城 - 國賓大戲院 - 電影 - 現正熱映 - 1/2的魔法
#   date = 05/23
#   theater = 國賓大戲院
#   time = 11:10
#   ting = 2廳 116席
# ->
#   1/2的魔法, 05/23, 國賓大戲院, 11:10, 2廳

# generate a temp txt
cp $TXT $TMP

# remove unnessary data
`sed -i 's/國賓電影網站入口 - 國賓影城 - 國賓大戲院 - 電影 - 現正熱映 - //g' $TMP`
`sed -i 's/[0-9]*席//g' $TMP`

# title/date/theater/time/ting
`sed -i '1 s/title = //g' $TMP`
`sed -i 's/date = //g' $TMP`
`sed -i 's/theater = //g' $TMP`
`sed -i 's/time = //g' $TMP`
`sed -i 's/ting = //g' $TMP`

# replace newline
`sed -i ':a;N;$!ba;s/\n/,/g' $TMP`

# fix
`sed -i 's/,,//g' $TMP`
`sed -i 's/title = /\n/g' $TMP`
`sed -i 's/\s//g' $TMP`
`sed -i '/---/ d' $TMP`

# convert to .csv
mv $TMP $CSV
