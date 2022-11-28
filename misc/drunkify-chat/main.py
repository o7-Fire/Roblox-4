from flask import Flask, request
from translate import Translator
import translators as ts
import random
import requests

codes = ['fr', 'ru', 'ja', 'ko']
app = Flask(__name__)

@app.route("/")
def main():
    textinput = request.args.get("textinput")
    interval = int(request.args.get("interval"))
    loopi = 1
    while loopi != interval:
        try:
            b = Translator(to_lang=random.choice(codes)).translate(textinput)
            textinput = b
        except requests.exceptions.HTTPError as e:
            print(e)
            interval += 1
        loopi += 1
    return ts.bing(textinput, to_language="en")

app.run(host="0.0.0.0", port=8080)
