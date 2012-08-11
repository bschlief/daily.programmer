#!/usr/bin/env ruby
# Run-Length encoding is a simple form of compression that detects 'runs' of 
# repeated instances of a symbol in a string and compresses them to a list of 
# pairs of 'symbol' 'length'. For example, the string
# "Heeeeelllllooooo nurse!"
# Could be compressed using run-length encoding to the list of pairs [(1,'H'),
# (5,'e'),(5,'l'),(5,'o'),(1,'n'),(1,'u'),(1,'r'),(1,'s'),(1,'e')]
# Which seems to not be compressed, but if you represent it as an array of 18
# bytes (each pair is 2 bytes), then we save 5 bytes of space compressing this
# string.
# Write a function that takes in a string and returns a run-length-encoding of
# that string. (either as a list of pairs or as a 2-byte-per pair array)
# BONUS: Write a decompression function that takes in the RLE representation 
# and returns the original string
# Retrieved on 8-6-2012 from 
# http://www.reddit.com/r/dailyprogrammer/comments/xxbbo/882012_challenge_86_easy_runlength_encoding/


input = "Heeeeelllllooooo nurse!"

# the scan and regex produces pairs that have
# to be married, the first matching character
# and any characters following it.
def encode_scan(input)
  input.scan(/(.)(\1*)/).map do |arr|
    grp = arr.first + arr.last
    [grp.length, arr.first]
  end
end

# this regex is a little cuter, and the use of 
# the gsub allows iterating over the resulting
# enumerator
def encode_gsub(input)
  input.gsub(/((.)\2*)/).inject([]) do |arr,grp|
    arr << [grp.length, grp[0]]
  end
end

def decode(input)
  input.inject("") { |str,arr| str << arr.last * arr.first }
end

puts encode_scan(input).inspect
puts decode(encode_scan(input)) == input

puts encode_gsub(input).inspect
puts decode(encode_gsub(input)) == input
