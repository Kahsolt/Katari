#!/usr/bin/env ruby
# Author: Armit
# Create Time: 2020/03/15 

# Brute-Force for NPC problem SAT

FIN = 'SAT.txt'
NEG_SYM = '~'

def evaluate(ass)
  intp = ($vars.zip ass).to_h
  res = $phi.map do |cls|
    res2 = cls.map do |let|
      (let.start_with? NEG_SYM) ? (1 - intp[let[1..-1]]) : intp[let]
    end
    ((res2.count 1) > 0) ? 1 : 0
  end
  (res.reduce :+) == $phi.length
end

def BF_SAT(nlen)
  sat = false
  ass = nil
  for i in 0...(2**nlen)
    ass = ((format "%0#{nlen}b", i).split '').map {|e| e.to_i}
    sat = evaluate ass
    break if sat
  end

  # result
  puts sat ? "Solution: #{ass.join}" : "Unsatisfiable"
end

# main
$phi = (File.read FIN).each_line.map {|line| line.split}
$vars = $phi.flatten.map {|let| (let.start_with? NEG_SYM) ? let[1..-1] : let}.uniq.sort

puts "Solving SAT:"
puts "  phi = (#{($phi.map {|cls| '(' + cls.join('|') + ')'}).join '&'})"
BF_SAT $vars.length
