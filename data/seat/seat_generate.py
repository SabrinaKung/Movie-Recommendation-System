import sys

# 26 col
column = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
# 20 row
row = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]

displaydate = "0620-0627"
seat = []
with open("../display/display_data" + displaydate + ".csv", encoding="utf-8") as display:
    data = display.readlines()
    data = data[1:]
    for line in data:
        line = line.strip()
        features = line.split(",")
        date = features[1]
        theater = features[2]
        time = features[4]
        TT = [theater, date, time]
        if TT not in seat:
            seat.append(TT)
    display.close()


print("theater,date,time,column,row,booked")
for S in seat:
    for C in column:
        for R in row:
            print(f"{S[0]},{S[1]},{S[2]},{C},{R},0")

