from ctypes import windll
from PIL import ImageGrab
from flask import Flask
import math
import threading
import time

xs = 61
ys = 30
screensize = (windll.user32.GetSystemMetrics(0), windll.user32.GetSystemMetrics(1))
dc= windll.user32.GetDC(0)
app = Flask(__name__)
colours = (
    (0, 0, 0, "🖤"),
    (192, 192, 192, "💿"),
    (128, 128, 128, "🌑"),
    (255, 255, 255, "🤍"),
    (128, 0, 0, "🍒"),
    (255, 0, 0, "❤️"),
    (128, 0, 128, "💜"),
    (255, 0, 255, "🌸"),
    (0, 128, 0, "🌳"),
    (0, 255, 0, "📗"),
    (128, 128, 0, "🦖"),
    (255, 255, 0, "🍋"),
    (0, 0, 128, "🔵"),
    (0, 0, 255, "📘"),
    (0, 128, 128, "🧪"),
    (0, 255, 255, "🐋")
)

def getpixel(x,y):
    global image
    color = image.getpixel((x, y))
    return color

def nearest_colour(query):
    lowest = ""
    lowestnum = 10000000000000000000
    for colour in colours:
        nint = ( ((query[0] - colour[0])**2) + ((query[1] - colour[1])**2) + ((query[2] - colour[2])**2) ) ** (1/2)
        #print(nint)
        if nint < lowestnum:
            lowest = colour[3]
            lowestnum = nint
    #print(lowest)
    return lowest

temps = {}
image = {}
@app.route("/")
def main():
    global temps, image
    image = ImageGrab.grab()
    finalmessage = ""
    ycount = 1
    for y in range(1, screensize[1], math.floor(screensize[1] / ys)):
        def doa(yy, yc):
            global temps
            global screensize
            xc = 1
            for x in range(1, screensize[0], math.floor(screensize[0] / xs)):
                p = getpixel(x,yy)
                #print((x, yy), p)
                temps[f"{str(xc)}A{str(yc)}"] = nearest_colour(p)
                xc += 1
        t1 = threading.Thread(target=doa, args=(y, ycount))
        t1.start()
        ycount += 1
    #time.sleep(.2)
    for y in range(ys):
        for x in range(xs):
            try:
                finalmessage += temps[f"{str(x+1)}A{str(y+1)}"]
            except:
                finalmessage += "📘"
            #print(finalmessage)
        finalmessage += "\n"
    return finalmessage

app.run(host="0.0.0.0", port=8080)
