#!/usr/bin/env ruby

# Description:
# Let the term "sum-pair" be a pair of integers A and B such that the sum of A 
# and B equals a given number C. As an example, let C be 10. Thus, the pairs 
# (5, 5), (1, 9), (2, 8), etc. are all sum-pairs of 10.
# Your goal is to write a program that, given an array through standard input 
# (console), you echo out all sum-pairs of a given integer C.
# Formal Inputs & Outputs:
# Input Description:
# On the console, you will be first given an integer N. This is the number of 
# following integers that are part of the array. After the N integers, you will
# be given an integer C which represents the sum-pair you are attempting to 
# match.
#
# Output Description:
# Your program must print all unique pair of integers in the given list, where 
# the sum of the pair is equal to integer C.
#
# Sample Inputs & Outputs:
# Input (Through Console)
# 4
# 1 -3 4 10
# 5
# Output (Through Console)
# 1, 4
#
# Note that there is only one pair printed to the console since there is only 
# one unique pair (1, 4) that has the sum of C (5).
# Challenge Input:
# We will show the solution of this problem data-set in 7-days after the 
# original submission.
# 14
# 10 -8 2 1 4 -9 6 1 9 -10 -5 2 3 7
# 7
# Note:
# (Awesome points awarded to /u/drigz [1] for getting some important 
# information into my thick-skull: there are linear-time solutions!)
# This is a common interviewing problem for programming jobs, so treat it as 
# such! There is a very trivial solution, but the trivial solution will run in 
# O(N2 )[2] time. There are a few other known solutions: one that runs in 
# O(N Log(N)) time (hint: takes advantage of sorting), and another in linear 
# time (hint: dictionary).
#
# Retrieved from http://www.reddit.com/r/dailyprogrammer/comments/15wm48/132013_challenge_115_intermediate_sumpairings/ 


puts "Enter number of inputs:" 
num_inputs = gets.to_i

puts "Enter integers:"
ints = readline.split.map { |i| i.to_i }

puts "Enter target num:"
c = gets.to_i

lut = Hash.new

# Create lookup table for number of instances
# of a particular integer. We need to count number of
# times a number shows up to check for case where a == b. 
ints.each do |a|
  lut[a] += 1 if lut[a]
  lut[a] ||= 1
end

# check each key to see if key and c-key is in the LUT. 
lut.keys.each do |a|
  # Handles most cases where a and (c-a) are in the LUT.
  # Eliminate duplicates by ensuring that a is less than (a-c)
  # so first number will be smaller than second number. 
  puts "(#{a}, #{c-a})" if ((lut[a] && lut[c-a]) && (a < (c-a)))  

  # if a == (c-a) == b, then a and b are the same, so we need
  # at least two copies of the number in the inputs.
  puts "(#{a}, #{c-a})" if ((a == (c-a)) && (lut[a] > 1))
end




