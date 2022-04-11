from flask import Flask
from flask import request
from threading import Thread
import random
app = Flask('')

remotes = []

@app.route('/')
def main():
  return "alive"

@app.route('/send', methods=['GET'])
def send():
  try:
    data = request.args.get('data')
  except:
    return "error"
  remotes.append(data)
  print(f"data received: {data}")
  return "success"

@app.route('/receive', methods=['GET'])
def receive():
  if len(remotes) < 0:
    return "no remotes to beam"
  else:
    randomremotetobeam = random.choice(remotes)
    remotes.remove(randomremotetobeam)
    print(f"data beamed: {randomremotetobeam}")
    return randomremotetobeam
    
app.run(host="0.0.0.0", port=8080)
