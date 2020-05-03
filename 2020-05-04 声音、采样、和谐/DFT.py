#!/usr/bin/env python3
# 2019/03/01 

import numpy as np
import matplotlib.pyplot as plt

def DFT(data):
  '''
    用一个周期为T的正弦波去探测待测信号
    采样点乘积加和的值即暗示了该周期下的分量
  '''
  
  N = len(data)
  REAL, IMAG = np.zeros_like(data), np.zeros_like(data)
  for k in range(N):
    for i in range(N):
      theta = (2 * np.pi * k) * (i / N)  # f=(k*i/N), the probe/scanning signal frequency
      REAL[k] += data[i] * np.cos(theta)
      IMAG[k] -= data[i] * np.sin(theta)
  MODULA = np.array([np.sqrt(r * r + i * i) for r, i in zip(REAL, IMAG)])
  return REAL, IMAG, MODULA

if __name__ == '__main__':
  # 频率分辨率F = fs/2N：DFT分析得到的最靠近两个信号频率之间的间隔
  N = 512     # 采样点数/数据长度，FFT点数
  fs = 64     # 采样频率(Hz)，每秒多少个数据点
  T = N / fs  # 采样时长(s)
  t = np.arange(N) / fs  # 采样点时刻序列
  
  FREQ1, AMP1 = 20, 1.2
  FREQ2, AMP2 = 30, -3.7
  Y = AMP1*np.sin(2*np.pi*FREQ1*t) + AMP2*np.sin(2*np.pi*FREQ2*t)    # 时域信号Y=f(t)
  #Y = [y + np.random.normal(scale=0.1) for y in Y]        # Gaussian noise

  R, I, M = DFT(Y)
  plt.subplot(2, 2, 1)
  plt.plot(t, Y)
  plt.subplot(2, 2, 2)
  plt.plot(R, 'r')
  plt.subplot(2, 2, 3)
  plt.plot(I, 'g')
  plt.subplot(2, 2, 4)
  plt.plot(M, 'b')    # symmetric
  
  # freq:
  #   若采用1024点fft，采样频率是fs
  #   那么第一个点对应频率0(Hz)，第512点对应的就是频率fs/2(Hz)
  # amp:
  #   采样点数为N，FFT结果的每个点的模值就是原始振幅的N/2倍
  #   第一个点是直流分量，它的模值就是直流分量的N倍
  for i in range(len(M)>>1):
    freq = fs*i/N
    amp = M[i]*2/N
    if amp > 0.1:
      print('freq: %.2f  amp: %.2f' % (freq, amp))
  
  plt.show()