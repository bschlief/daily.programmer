#!/usr/bin/env ruby

# For today's challenge, you should calculate some simple statistical values 
# based on a list of values. Given this data set, write functions that will 
# calculate:
#
#  The mean value
#  The variance
#  The standard deviation
#
# Obviously, many programming languages and environments have standard 
# functions for these (this problem is one of the few that is really easy to 
# solve in Excel!), but you are not allowed to use those! The point of this 
# problem is to write the functions yourself.
#
# Thanks to Cosmologicon for suggesting this problem at /r/dailyprogrammer_ideas!
#
# Retrieve from http://www.reddit.com/r/dailyprogrammer/comments/y5sox/8132012_challenge_88_easy_vigen%C3%A8re_cipher/ 
# on 8-20-2012

    class Array 
      def sum 
        self.inject(:+) 
      end

      def mean 
        self.sum / self.size 
      end

      def variance
        mu = self.mean
        (self.inject(0) { |res,n| res += (n-mu)** 2 })/self.size
      end 

      def std_dev 
        self.variance ** 0.5 
      end
    end

    vals = IO.readlines("data/89.easy.input.txt").map { |line| line.to_f }

    puts "Mean:\t\t#{vals.mean}"
    puts "Variance:\t#{vals.variance}"
    puts "Std Dev:\t#{vals.std_dev}"

