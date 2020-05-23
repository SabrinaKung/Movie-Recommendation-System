import requests as rq
import sys
import codecs
from bs4 import BeautifulSoup

# python stdout default encodes ansi, change to utf-8
sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())

url = "https://www.ambassador.com.tw/home/MovieList?Type=1"
response = rq.get(url)

def getweek(url):
    month = int(url[-5] + url[-4])
    day = int(url[-2] + url[-1])
    week = []
    for i in range(7):
        # only May to Sep
        if month == 5 and day+i > 31:
            week.append(str(month+1).zfill(2) + '/' + str(day+i-31).zfill(2))
        elif month == 6 and day+i > 30:
            week.append(str(month+1).zfill(2) + '/' + str(day+i-30).zfill(2))
        elif month == 7 and day+i > 31:
            week.append(str(month+1).zfill(2) + '/' + str(day+i-31).zfill(2))
        elif month == 8 and day+i > 31:
            week.append(str(month+1).zfill(2) + '/' + str(day+i-31).zfill(2))
        else:
            week.append(str(month).zfill(2) + '/' + str(day+i).zfill(2))
    return week

def gethref(dom):
    soup = BeautifulSoup(dom, features="html.parser")
    moviehref = soup.find_all("h6")
    for H in moviehref:
        #print(f"H = {H}")
        #print(H.find('a').get('href'))
        nexturl = H.find('a').get('href')
        homeurl = "https://www.ambassador.com.tw"
        url = homeurl+nexturl
        week = getweek(url)
        #print(week)
        # remove last 5 words from url
        url = url[:-5]
        for day in week:
            print(url + day)
            response = rq.get(url+day)
            x = response.text
            SS = BeautifulSoup(x, features="html.parser")
            theater = SS.find('div', class_='theater-box')
            if theater != []:
                getmovie(SS)
            else:
                break


def getmovie(soup):
    print(f"title = {soup.find('title').text}")
    theater = soup.find_all('div', class_='theater-box')
    for T in theater:
        print(f"theater = {T.find('a').text}")
        for time, ting in zip(T.find_all('h6'), T.find_all('span', "float-left info")):
            print(f"time = {time.text}")
            print(f"ting = {ting.text}")
        #for time in T.find_all('h6'):
        #    print(f"time = {time.text}")
        #for ting in T.find_all('span'):
        #    print(f"ting = {ting.text}")
    print("-------------------------------------------------------------------------\n")


def main():
    x = response.text
    gethref(x)


if __name__ == "__main__":
    main()

