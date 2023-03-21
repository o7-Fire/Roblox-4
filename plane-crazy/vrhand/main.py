import cv2
import mediapipe as mp
import time
from flask import Flask
import threading

tosendout = ""
app = Flask(__name__)
mpHands = mp.solutions.hands
hands = mpHands.Hands(static_image_mode=False,
                      model_complexity=1,
                      max_num_hands=1,
                      min_detection_confidence=0.3,
                      min_tracking_confidence=0.3)
mpDraw = mp.solutions.drawing_utils

class handDetector():
    def __init__(self):
        self.mpHands = mpHands
        self.hands = hands
        self.mpDraw = mpDraw
    
    def findHands(self, img, draw=True):
        imgRGB = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        self.results = self.hands.process(imgRGB)
        # print(results.multi_hand_landmarks)
        
        if self.results.multi_hand_landmarks:
            for handLms in self.results.multi_hand_landmarks:
                if draw:
                    self.mpDraw.draw_landmarks(img, handLms, self.mpHands.HAND_CONNECTIONS)
        return img
    
    def findPosition(self, img, handNo=0, draw=True):
        
        lmlist = []
        if self.results.multi_hand_landmarks:
            myHand = self.results.multi_hand_landmarks[handNo]
            for id, lm in enumerate(myHand.landmark):
                h, w, c = img.shape
                cx, cy, cz = int(lm.x * w), int(lm.y * h), int(lm.z * w)
                lmlist.append([id, cx, cy, cz])
                if draw:
                    cv2.circle(img, (cx, cy), 3, (0, abs(cz), abs(cz)), cv2.FILLED)
        return lmlist


def main():
    global tosendout
    pTime = 0
    cTime = 0
    cap = cv2.VideoCapture(0)
    detector = handDetector()
    
    while True:
        success, img = cap.read()
        img = detector.findHands(img)
        lmlist = detector.findPosition(img)
        if len(lmlist) != 0:
            tobeamout = ""
            for l in lmlist:
                tobeamout += f"{str(l[0])} {str(round(l[1]))} {str(round(l[2]))} {str(round(l[3]))}B"
            tosendout = tobeamout[:-1]
        #    print(lmlist[4])
        
        cTime = time.time()
        fps = 1 / (cTime - pTime)
        pTime = cTime
        
        cv2.putText(img, str(int(fps)), (10, 70), cv2.FONT_HERSHEY_PLAIN, 3, (255, 0, 255), 3)
        
        cv2.imshow("Image", img)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
        
    cap.release()
    cv2.destroyAllWindows()
    
t = threading.Thread(target=main)
t.start()

@app.route("/")
def mainaeaeaeae():
    return tosendout

app.run(host="0.0.0.0", port=8080)
