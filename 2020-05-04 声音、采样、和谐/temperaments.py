#!/usr/bin/env python3
# Author: Armit
# Create Time: 2020/05/02 

import numpy as np
import matplotlib.pyplot as plt

A4 = 440

def twelvetone_equal(base):
  return np.array([base*2**(i/12) for i in range(13)])

def circle_of_fifth(base):
  lower, upper = 1, 2
  retA, retD = [lower, upper], [lower, upper]
  
  # asc
  cur = lower
  for _ in range(11):
    cur = cur * (3 / 2)
    if cur > upper: cur /= 2
    retA.append(cur)
  # desc
  cur = upper
  for _ in range(11):
    cur = cur * (2 / 3)
    if cur < lower: cur *= 2
    retD.append(cur)
  
  retA, retD = base * np.array(sorted(retA)), base * np.array(sorted(retD))
  ret = (retA + retD) / 2
  return ret, retA, retD

if __name__ == '__main__':
  TE = twelvetone_equal(A4)
  print(['%.4f'%(b/a) for a, b in zip(TE, TE[1:])])
  CF, CFA, CFD = circle_of_fifth(A4)
  print(['%.4f'%(b/a) for a, b in zip(CF, CF[1:])])
  
  plt.plot(TE,  'r')
  plt.plot(CF,  'b')
  plt.plot(CFA, 'b*')
  plt.plot(CFD, 'b.')
  
  plt.show()