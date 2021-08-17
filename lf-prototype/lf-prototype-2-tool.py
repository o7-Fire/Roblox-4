from flask import Flask
import threading
import time
import random

app = Flask(__name__)
returnstring = "A"

@app.route("/")
def main():
    return returnstring.encode()

def randomizestring():
    global returnstring
    returnmessage = ""
    while True:
        for frames in range(120):
            for x in range(24):
                for y in range(24):
                    rgb = random.randint(50, 100)
                    r = random.randint(0, 200)
                    g = random.randint(0, 100)
                    b = random.randint(0, 200)
                    returnmessage = returnmessage + f"{x+1} {y+1} {rgb} {rgb} {rgb}A"
            returnmessage = returnmessage + "N"
        returnstring = returnmessage
        returnmessage = ""
        time.sleep(30)
            
t1 = threading.Thread(target=randomizestring)
t1.start()

app.run(host="0.0.0.0", port=8080)
