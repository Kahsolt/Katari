#!/usr/bin/env python3
# Author: Armit
# Create Time: 2020/03/22 
#
# a simple brainfuck interpreter and REPL
#

from msvcrt import getch
import sys
putc = sys.stdout.write

def run(prog):
  INST, PC = [i for i in prog], 0
  tape, head = [0], 0

  while True:
    if PC >= len(INST): break
    inst = INST[PC]; PC += 1
    if inst == '>':
      head += 1
      if head >= len(tape): tape.append(0)
    elif inst == '<':
      if head > 0: head -= 1
      else: tape.insert(0, 0)
    elif inst == '+':
      tape[head] = (tape[head] + 1) % 128
    elif inst == '-':
      tape[head] = (tape[head] - 1) % 128
    elif inst == '.':
      putc(chr(tape[head]))
    elif inst == ',':
      tape[head] = ord(getch())
    elif inst == '[':
      if tape[head] == 0:
        layer = 0
        while True:
          if INST[PC] == '[':
            layer += 1
          elif INST[PC] == ']':
            if layer == 0: break
            else: layer -= 1
          PC += 1
        PC += 1
    elif inst == ']':
      if tape[head] != 0:
        PC -= 2
        layer = 0
        while True:
          if INST[PC] == ']':
            layer += 1
          elif INST[PC] == '[':
            if layer == 0: break
            else: layer -= 1
          PC -= 1
        PC += 1
    else: raise RuntimeError

if __name__ == '__main__':
  try:
    print('[*] Engine ready.\n')
    while True:
      putc(">> ")
      prog = input().strip()
      if prog:
        try:
          run(prog)
          print('\n[*] Success.')
        except:
          print('\n[x] Program runtime error.')
  except KeyboardInterrupt:
    pass