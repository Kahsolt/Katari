#!/usr/bin/env python3
# 2018-03-11

import numpy as np
from matplotlib import pyplot as plt

def euclid(x, y):
  cnt = 0
  if x < y:	# keep x >= y
    x, y = y, x
  while y != 0:
    r = x % y
    x = y
    y = r
    cnt += 1
  return cnt

N = 1000
data = np.array([[0] * N] * N, dtype=np.int64)
for i in range(N):
  for j in range(i, N):
    data[i][j] = euclid(i, j)

vmax = vmin = data[0][0]
for row in data:
  vmax = max(row) > vmax and max(row) or vmax
  vmin = min(row) < vmin and min(row) or vmin
map = plt.imshow(data, interpolation='nearest', vmin=vmin, vmax=vmax)
plt.colorbar(mappable=map, shrink=0.5)
plt.show()
