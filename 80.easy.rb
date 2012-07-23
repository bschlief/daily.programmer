# As all of us who have read "Harry Potter and the Chamber of Secrets" knows, 
# the reason He-Who-Must-Not-Be-Named chose his creepy moniker is that "I Am 
# Lord Voldemort" is an anagram for his birthname, "Tom Marvolo Riddle".

# I've never been good at these kinds of word-games (like anagrams), I 
# always find it hard to figure out that stuff manually. I find it much 
# more enjoyable to write computer programs to solve these problems for me.
# In the spirit of that, today's problem is to find simple one-word anagrams 
# for other words.
			
# Write a program that given a word will find all one-word anagrams for 
# that word. So, for instance, if you put in "LEPROUS", it should return 
# "PELORUS" and "SPORULE". As a dictionary, use [1] this file, which is a 
# 1.8 mb text-file with one word listed on each line, each word listed in 
# lower-case. In this problem description, I've used upper-case for all 
# words and their anagrams, but that is entirely optional, it's perfectly 
# all right to use lower-case if you want to.

# Using your program, find all the one-word anagrams for "TRIANGLE".
#	(by the way, in case anyone is curious: a "PELORUS" is "a sighting device 
#	on a ship for taking the relative bearings of a distant object", which 
#	I imagine basically is a telescope bolted onto a compass, and a "SPORULE" 
#	is "a small spore")

# Bonus: if you looked up the anagrams for "PAGERS", you'd find that there 
# was actually quite a few of them: "GAPERS", "GASPER", "GRAPES", "PARGES" 
# and "SPARGE". Those five words plus "PAGERS" make a six-word "anagram 
# family".

# Here's another example of an anagram family, this time with five words: 
# "AMBLERS", "BLAMERS", "LAMBERS", "MARBLES" and "RAMBLES".

#	What is the largest anagram family in the dictionary I supplied? What is 
#	the second largest?
#	Retrieved July 23, 2012 from 
#	http://www.reddit.com/r/dailyprogrammer/comments/x0v3e/7232012_challenge_80_easy_anagrams/



# BMS: My approach is as follows.  Load the dictionary into memory, take
# each string and sort it lexographically, and use that as a key in 
# a hash table.  At that key, I'll make a list of the unsorted words
# that match that key.  
#
# A bit heavy on the front end for processing, but will allow for very
# fast lookup later.


puts "Initializing..."

lines = Array.new
lines_key = Array.new
File.foreach("data/anagrams.txt") {
  | line |
	lines << line.chomp
	lines_key << line.chomp.chars.sort.join
}

puts "#{lines.length} lines read"

anaHash = Hash.new {|hash, key| hash[key] = [] }
for i in 0..lines.length do 
  anaHash[lines_key[i]] << lines[i] 
end

while true do
  print "Enter anagram searchword: "
  word = gets
  puts anaHash[word.chomp.chars.sort.join]
end


