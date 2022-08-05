from PIL import Image
import cv2
import time
import os
#import vlc
from moviepy.editor import *


def turnascii(image_path):
    img = Image.open(image_path)

    width, height = img.size
    aspect_ratio = height/width
    new_width = 50
    new_height = 38#aspect_ratio * new_width * 0.55
    img = img.resize((new_width, int(new_height)))

    returnmessage = ""
    for y in range(img.height):
        for x in range(img.width):
            r,g,b = img.getpixel((x,y))
            returnmessage = returnmessage + f"{r} {g} {b}A"
    return returnmessage + "N"
            

vidcap = cv2.VideoCapture('input.mp4')
success,image = vidcap.read()
count = 0
while success:
  cv2.imwrite(f"./frames/frame{count}.jpg", image) 
  success,image = vidcap.read()
  print(f"Rendered frame: {count}")
  
  with open(f"frames.txt", "a+") as f:
    writemessage = turnascii(f"./frames/frame{count}.jpg")
    f.write(writemessage)
    
  count += 1
