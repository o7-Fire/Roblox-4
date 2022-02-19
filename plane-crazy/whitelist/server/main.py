from flask import Flask
from flask import request
from threading import Thread
from collections import defaultdict
app = Flask('')

datac = defaultdict(list)

@app.route('/')
def main():
  return "alive"

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
  datatosave = data.split("N")
  a1 = datatosave[0].replace("S", ", ")
  a2 = datatosave[1].replace("S", ", ")
  a3 = datatosave[2]

  print(code in datac)
  datac[code].append("game:GetService('ReplicatedStorage').Remotes.PlaceBIockRegion:InvokeServer(unpack({" + f"Vector3.new({a1}), CFrame.new({a2}), {a3}, " + '""' + "}))")
  print(f"{code} {datac[code]}")
  return "success"

@app.route('/receive', methods=['GET'])
def receive():
  try:
    code = request.args.get('code')
  except:
    return "error"
  datatobeam = ""
  for data in datac[code]:
    datatobeam += f"{data}SPACE"
  datac[code] = []
  return datatobeam

app.run(host="0.0.0.0", port=8080)
