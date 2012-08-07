#!/usr/bin/env ruby

# get the array from STDIN
arr = []
ARGF.each { |line| arr << line.chomp!.scan(/\d+/).map { |s| s.to_i } }

# transpose the array
arr_t = arr.transpose

# sum as a reduction for each row, and the columns
arr_sums   = arr.map   { |a| a.inject { |sum,n| sum + n } }
arr_t_sums = arr_t.map { |a| a.inject { |sum,n| sum + n } }

# print Rows and Columns
printf "Rows:"
arr_sums.each { |i| printf " %d" % i }
printf "\n"

printf "Columns:"
arr_t_sums.each { |i| printf " %d" % i }
printf "\n"

# sort by row and column sums
arr.sort! { |a,b| a.inject(:+)  <=> b.inject(:+)  }
arr_t.sort! { |a,b| a.inject(:+) <=> b.inject(:+) }

 
arr.each do |a|
  a.each { |i| printf (" " + i.to_s).ljust(4) }
  printf "\n"
end
printf "\n"
arr_t.transpose.each do |a|
  a.each { |i| printf (" " + i.to_s).ljust(4) }
  printf "\n"
end
