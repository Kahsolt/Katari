#!/usr/bin/env ruby
# Author: Armit
# Create Time: 2020-04-14

class Person

  def initialize(name, age)
    @name = name
    @age = age
  end

  def inspect
    "<Person name=#{@name} age=#{@age}>"
  end

end

class Dog

  def initialize(name, master=nil)
    @name = name
    @master = master
  end
  
  def inspect
    "<Dog name=#{@name} master=#{@master}>"
  end

end

p = Person.new "Persona", 1919
d = Dog.new "Douglas", p

class Object

end

class Class

end
