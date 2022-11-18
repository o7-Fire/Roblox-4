from PIL import Image, ImageDraw, ImageFont
from flask import Flask
import math
import threading
import time
import os
import random

xs = 60
ys = 33
app = Flask(__name__)

colours = (
    (71, 206, 46, "💚"), (194, 219, 153, "🥬"), (176, 245, 255, "💧"),
    (240, 230, 140, "💡"), (157, 208, 74, "🍏"), (179, 29, 25, "🍓"),
    (167, 242, 89, "🍀"), (249, 204, 80, "🌕"), (173, 216, 230, "🧊"),
    (0, 0, 0, "🖤"),
    (192, 192, 192, "💿"),
    (128, 128, 128, "🌑"),
    (255, 255, 255, "🤍"),
    (128, 0, 0, "🍒"),
    (255, 0, 0, "❤"),
    (255, 100, 100, "👛"),
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
    print(color)
    return color

def nearest_colour(query):
    lowest = ""
    lowestnum = 10000000000000000000
    for colour in colours:
        nint = ( ((query[0] - colour[0])**2) + ((query[1] - colour[1])**2) + ((query[2] - colour[2])**2) ) ** (1/2)
        if nint < lowestnum:
            lowest = colour[3]
            lowestnum = nint
    return lowest

font = ImageFont.truetype("arial.ttf", 12)
@app.route("/randomflag")
def main():
    temps = {}
    image = Image.open( f'./flags/{random.choice(os.listdir("./flags"))}' ).convert("RGB")
    image = image.resize((xs, ys), resample=1)
    draw = ImageDraw.Draw(image)
    #if random.randint(1, 5) != 1:
    draw.line( (xs, 0, 0, ys), fill=(255,0,0), width=5 )
    draw.line( (0, 0, xs, ys), fill=(255,0,0), width=5 )
    draw.text( (0,1), "FUCK THIS", fill=(255,255,255), font=font, align="left" )
    draw.text( (15, 11), "", fill=(255,255,255), font=font, align="middle" )
    draw.text( (1, 21), "COUNTRY", fill=(255,255,255), font=font, align="left" )
    #else:
    #    draw.line( (0, math.floor(ys/2), math.floor(xs/3), ys), fill=(0,255,0), width=5 )
    #    draw.line( (math.floor(xs/3), ys, xs, 0), fill=(0,255,0), width=5 )
    #    draw.text( (0,1), "THIS GOOD", fill=(255,255,255), font=font, align="left" )
    #    draw.text( (15, 11), "", fill=(255,255,255), font=font, align="middle" )
    #    draw.text( (1, 21), "COUNTRY", fill=(255,255,255), font=font, align="left" )
        
    pixels = image.load()
    finalmessage = ""
    for y in range(1, ys, 1):
        for x in range(1, xs, 1):
            p = pixels[x, y]
            finalmessage += nearest_colour(p)
        finalmessage += "\n"
    return finalmessage

app.run(host="0.0.0.0", port=8080)
