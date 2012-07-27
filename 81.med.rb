# For a lot of the questions today we are going to be doing some simple 
# numerical calculus. Don't worry, its not too terrifying.
# 
# Write a function fmin that can take in a real-valued function f(x) where x 
# is a vector in 3D space (bonus points for N-D).
# 
# qxout=fmin(f,x0) should return a local minimum of f close to x0.
# Example in Python
# %f is a function with 1 3-vector
# def f(x):
#    return x[0]**2+x[1]**2+x[2]**2

#		%find the local minimum of f, starting at (1,1,1)
#		print fmin(f,[1.0,1.0,1.0])
#		should print out
#		[0.0,0.0,0.0]  %because (0,0,0) is the global minimum of f(x,y,z)=x^2+y^2+z^2
#		EDIT: To make this a little easier, I decided that it is acceptable for your 
#		implementation to require that fmin have additional arguments for the 
#		derivatives of f

# BMS: My approach will be to do a genetic algorithm search, seeding the 
# population with the initial vector, with some global tuned variance 
# around that initial vector.  Also parameterize the dimension
# Uses the Rubystats gem for gaussian random numbers
#  -- sudo gem install rubystats

# Retrieved July 26, 2012 from 
# http://www.reddit.com/r/dailyprogrammer/comments/x539t/7252012_challenge_81_intermediate_local/

require 'rubygems'
require 'rubystats'
require 'pp'

SIZE = 10
DIM = 2
INIT_ARR = [3.0, -8.0, 100.0, 42, 78] #Array.new(DIM, 1.0)
DEV_ARR = [1.0, 1.0, 1.0, 0.1, 0.3] #Array.new(DIM, 1.0)

class Population
	attr_accessor :pop 
  attr_accessor :fitness

	def initialize (size, dimension, init_arr, dev_arr)
		super()
    @normals = Array.new(DIM) { |i| Rubystats::NormalDistribution.new(init_arr[i], dev_arr[i]) }
    @pop = []
		@fitness = []
		for i in 0..size
			@pop << Array.new(DIM) { |i| @normals[i].rng }
			@fitness << f(@pop[i])
		end
	end

  def f (arr)
    arr.inject(0) { |result,n| result + (n ** 2) }
	end

end

p = Population.new(SIZE, DIM, INIT_ARR, DEV_ARR)
pp(p.pop)
pp(p.f([2,2,2,2]))
#pp(p.normal_rng_arr)

#norm = Rubystats::NormalDistribution.new(3,1)
