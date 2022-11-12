from PIL import Image
from io import BytesIO
import base64
import requests

emojidata = requests.get('https://unicode.org/emoji/charts/full-emoji-list.html').text #courtesy of stackoverflow
emojistodo = "💚🥬💧💡🍏🍓"

def to_base64_png(emoji, version=0): #courtesy of stackoverflow
    html_search_string = r"<img alt='{}' class='imga' src='data:image/png;base64,([^']+)'>"
    matchlist = re.findall(html_search_string.format(emoji), emojidata)
    return matchlist[version]

finalstring = ""
for emoji in emojistodo:
    try:
        b64 = to_base64_png(emoji)
        image = Image.open( BytesIO(base64.b64decode(b64)) )
        #reduced = image.convert("P", palette=Image.WEB)
        image = image.convert("RGBA")
        image = image.resize((1,1), resample=0)
        c = image.getpixel((0,0))
        finalstring += f'({str(c[0])}, {str(c[1])}, {str(c[2])}, "{emoji}"),\n'
    except Exception as e:
        print("error: " + str(e))
print(finalstring)
