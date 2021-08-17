from PIL import Image
import cv2
import time
import os
#import vlc
from moviepy.editor import *

def turnascii(image_path):
    # pass the image as command line argument
    img = Image.open(image_path)
    
    # resize the image
    width, height = img.size
    aspect_ratio = height/width
    new_width = 24
    new_height = 24#aspect_ratio * new_width * 0.55
    img = img.resize((new_width, int(new_height)))
    # new size of image
    # print(img.size)
    
    # convert image to greyscale format
    returnmessage = ""
    for x in range(img.width):
        for y in range(img.height):
            r,g,b = img.getpixel((x,y))
            returnmessage = returnmessage + f"{x+1} {y+1} {r} {g} {b}A"
    return returnmessage + "N"
            

vidcap = cv2.VideoCapture('input.mp4')
success,image = vidcap.read()
count = 0
while success:
  cv2.imwrite(f"./frames/frame{count}.jpg", image)     # save frame as JPEG file
  success,image = vidcap.read()
  print(f"Rendered frame: {count}")
  
  with open(f"frames.txt", "a+") as f:
    writemessage = turnascii(f"./frames/frame{count}.jpg")
    f.write(writemessage)
    
  count += 1
 
'''
videoclip = VideoFileClip("input.mp4")
audioclip = videoclip.audio
audioclip.write_audiofile("input.mp3")
audioclip.close()
videoclip.close()
time.sleep(0.5)
p = vlc.MediaPlayer("input.mp3")
p.play()

while True:
 for i in range(count):
     if i % 90 == 0:
         p.set_position((i / 6568))
     time.sleep(1 / 40)
     print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + turnascii(f"./frames/frame{i}.jpg"))
     os.remove(f"./frames/frame{i}.jpg")
 os.remove("input.mp3")
 break
 '''
 
