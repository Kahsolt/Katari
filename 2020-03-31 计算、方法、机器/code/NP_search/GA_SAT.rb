#!/usr/bin/env ruby
# Author: Armit
# Create Time: 2020/03/14 

# Genetic Algorithm for NPC problem SAT

FIN = 'SAT.txt'
NEG_SYM = '~'

MAX_ITER = 1000
EPS = 1e-5
POPLATION_SIZE = 50
MUTATION_RATE = 0.05
CROSSOVER_RATE = 0.5
ELITISM_COUNT = 0

def evaluate(indv)
  intp = ($vars.zip indv.chromosome).to_h
  res = $phi.map do |cls|
    res2 = cls.map do |let|
      (let.start_with? NEG_SYM) ? (1 - intp[let[1..-1]]) : intp[let]
    end
    ((res2.count 1) > 0) ? 1 : 0
  end
  (res.reduce :+) / $phi.length
end

class Individual

  attr_accessor :chromosome, :fitness

  def initialize(x)
    if x.is_a? Integer then
      @chromosome = x.times.map {rand 2}
      @fitness = 0
    elsif x.is_a? Array then
      @chromosome = x
    end
  end
  
  def [](idx)
    @chromosome[idx]
  end
  
  def []=(idx, val)
    @chromosome[idx] = val
  end
  
  def <=>(other)
    @fitness <=> other.fitness
  end
  
  def to_s
    format "%.2f - %s", @fitness, @chromosome.join
  end

  def inspect
    "<Individual chromosome=#{@chromosome.join} fitness=#{@fitness}>"
  end

end

class Population

  attr_accessor :individuals

  def initialize(npopl, nchr=nil)
    @individuals = (nchr.nil? ? npopl.times.map {nil} : npopl.times.map {Individual.new(nchr)})
  end

  def crossover!
    @individuals[ELITISM_COUNT..-1].each do |indv|
      other = @individuals.sample
      for idx in 0...(indv.chromosome.length)
        indv[idx] = other[idx] if rand < CROSSOVER_RATE  # replace by mother's gene
      end
    end
  end

  def mutate!
    @individuals.each do |indv|
      indv.chromosome = indv.chromosome.map do |gene|
        (rand < MUTATION_RATE) ? (1 - gene) : gene        # toggle 0/1
      end
    end
  end
  
  def eval
    @individuals.each {|indv| indv.fitness = evaluate indv}
    @individuals.sort!.reverse!
  end

  def best_individual
    @individuals.select.max {|indv| indv.fitness}
  end
  
  def ragnarok?
    1.0 - best_individual.fitness < EPS
  end

end

def GA_SAT(npopl, nchr)
  # init population and generation count
  eaons = 1
  popl = Population.new(npopl, nchr)
  popl.eval
  
  # do search
  while not popl.ragnarok? and eaons < MAX_ITER
    # current result
    puts "Best at #{eaons}th generation: #{popl.best_individual}"
    
    # transform
    popl.crossover!
    popl.mutate!
    
    # eval fitness
    popl.eval
    
    # time goes by (next generation
    eaons += 1
  end

  # result
  puts "End at #{eaons}th generation"
  puts "Last solution: #{popl.best_individual}"
  

end

# main
$phi = (File.read FIN).each_line.map {|line| line.split}
$vars = $phi.flatten.map {|let| (let.start_with? NEG_SYM) ? let[1..-1] : let}.uniq.sort

puts "Solving SAT:"
puts "  phi = (#{($phi.map {|cls| '(' + cls.join('|') + ')'}).join '&'})"
GA_SAT POPLATION_SIZE, $vars.length
