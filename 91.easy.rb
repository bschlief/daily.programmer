#!/usr/bin/env ruby
# An anonymous user on world4ch's programming text board posted a thread in 
# early 2011 in which he describes an ingenious O(n) sorting algorithm. This 
# means it's, supposedly, more efficient than any sorting algorithm ever 
# invented. Some bloggers picked up on it, and dubbed the algorithm sleep 
# sort[1] :
#!/bin/bash
#  function f() {
#   sleep "$1"
#   echo "$1"
# }
# while [ -n "$1" ]
#   do
#     f "$1" &
#       shift 
#     done
#   wait
# This program takes some command line arguments, like 
# ./sleepsort.sh 3 1 4 1 5 9
# and starts a new thread[2] for each number in the list, which first sleeps 
# for n seconds, then prints n. After 1 second, both 1s are printed, then 
# after 2 more seconds the 3 follows, etc. Because it only loops through the 
# list of numbers once, the algorithm appears to run in linear time.
# Your task is to re-implement sleep sort in a language of your choice (which 
# might look trivial, but this challenge is all about learning how your 
# language handles multithreading.)
# BONUS: at first glance, this algorithm appears to be O(n). Can you prove 
# this isn't true? (This bonus requires some knowledge of both algorithms and 
# concurrency.)
# Retreived Aug 25, 2012

# get the arguments passed converted to integers.
input = ARGV.map { |i| i.to_i }

# create threads, which sleep, then output values
threads = input.map do |i| 
  Thread.new do
    sleep(i)
    printf "#{i} "
  end
end

# join all threads, to wait for children to finish
threads.each { |t| t.join }

puts ""
