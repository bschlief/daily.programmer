#!/usr/bin/env ruby

#How many words contained in this dictionary have their letters in 
#alphabetical order? So, for instance the letters in "ghost" and "bee" is in 
#alphabetical order, but the letters in "cab" is not.

res = 0
ARGF.each do | line |
  line.chomp!
  sorted = line.chars.to_a.sort.join
  res += 1 if (line == sorted) 
end
puts res
