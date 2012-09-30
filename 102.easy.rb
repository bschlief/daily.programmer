#!/usr/bin/env ruby

# In tabletop role-playing games like Dungeons & Dragons, people use a system 
# called dice notation[1] to represent a combination of dice to be rolled to 
# generate a random number. Dice rolls are of the form AdB (+/-) C, and are 
# calculated like this:
#  Generate A random numbers from 1 to B and add them together.
#  Add or subtract the modifier, C.
#  If A is omitted, its value is 1; if (+/-)C is omitted, step 2 is skipped. 
#  That is, "d8" is equivalent to "1d8+0". Write a function that takes a 
#  string like "10d6-2" or "d20+7" and generates a random number using this syntax.
#  Here's a hint on how to parse the strings, if you get stuck:
#      Split the string over 'd' first; if the left part is empty, A = 1,
#      otherwise, read it as an integer and assign it to A. Then determine
#      whether or not the second part contains a '+' or '-', etc.

    input = ARGV.shift

    a_str, rest_str = input.split(/d/)
    a_str = "1" if a_str.empty?
    b_str, c_str = rest_str.split(/[+-]/)
    c_str = "0" if c_str.nil?

    op = :+   #= Assume add
    op = :- if rest_str.include?("-")

    sum = (1..a_str.to_i).inject(0) { |res,_| res += rand(b_str.to_i)+1 }
    sum_with_mod = sum.send(op, c_str.to_i)

    puts sum_with_mod
