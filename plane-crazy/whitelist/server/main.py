from flask import Flask
from flask import request
from threading import Thread
app = Flask('')

datac = {}

@app.route('/send', methods=['GET'])
def send():
  try:
    code = request.args.get('code')
  except:
    return "error"
  try:
    data = request.args.get('data')
  except:
    return "error"
  datac[code] = data
  print(f"{code} {data}")
  return "success"

@app.route('/receive', methods=['GET'])
def receive():
  return "alive 200"

app.run(host="0.0.0.0", port=8080)
