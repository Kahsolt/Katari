#!/usr/bin/env ruby
# Author: Armit
# Create Time: 2020/03/15 

# generate a 

FOUT = 'SAT.txt'
NEG_SYM = '~'

N = 50      # nvariable
M = 100     # nclause

N = ARGV[0].to_i if ARGV.length >= 1
M = ARGV[1].to_i if ARGV.length >= 2

fp = File.open FOUT, 'w'
for m in 1..M
  for n in 1..N
    if rand < 1/4 then
      if rand < 1/2 then
        fp.write NEG_SYM
      else
        fp.write ' '
      end
      fp.write "x#{n}"
    else
      fp.write ' ' * (n.to_s.length + 2)
    end
    fp.write ' '
  end
  fp.write "\n"
end
fp.close