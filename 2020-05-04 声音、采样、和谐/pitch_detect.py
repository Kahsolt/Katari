#!/usr/bin/env python3
# Author: Armit
# Create Time: 2020/05/01 

import numpy as np
from scipy.fft import rfft
from time import sleep
import pyaudio
import matplotlib.pyplot as plt

# Standard: 44100Hz 16bit Mono
FRAME_RATE = 44100
SAMPLE_WIDTH = 2
CHANNELS = 1
CHUNK = 1024
RECORD_SECONDS = 0.19

if __name__ == "__main__":
  p = pyaudio.PyAudio()
  stream = p.open(format=p.get_format_from_width(SAMPLE_WIDTH), channels=CHANNELS, rate=FRAME_RATE, input=True, output=True, frames_per_buffer=CHUNK)
  plt.ion()
  plt.xlim(10, 500)
  plt.ylim(0, 1.2)
  try:
    while True:
      chunks = b''
      nframes = max(1, int(FRAME_RATE / CHUNK * RECORD_SECONDS))
      for i in range(nframes):
        chunks += stream.read(CHUNK)
      data = np.frombuffer(chunks, dtype=np.int16)
      
      N = len(data)
      M = abs(rfft(data))
      idx = np.argmax(M)
      amp = M[idx] * 2 / N
      freq = FRAME_RATE * idx / N
      print('%.2f Hz (amp %.2f)' % (freq, amp))
    
      M = M / max(M)    # normalize
      plt.clf()
      plt.plot(M)
      plt.pause(0.01)

  except KeyboardInterrupt: pass
  finally:
    stream.close()
    p.terminate()
 

