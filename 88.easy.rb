#!/usr/bin/env ruby

# The easy challenge today is to implement the famous [1] Vigenère cipher. 
# The Wikipedia article explains well how it works, but here's a short 
# description anyway:
# You take a message that you want to encrypt, for instance "THECAKEISALIE" 
# (lets assume that all characters are upper-case and there are no spaces in 
# the messages, for the sake of simplicity), and a key you want to encrypt it 
# with, for instance "GLADOS". You then write the message with the key 
# repeated over it, like this:
#
# GLADOSGLADOSG
# THECAKEISALIE
# The key is repeated as often as is needed to cover the entire message.
# Now, one by one, each letter of the key is "added" to the letter of the 
# clear-text to produce the cipher-text. That is, if A = 0, B = 1, C = 2, 
# etc, then E + G = K (because E = 4 and G = 6, and 4 + 6 = 10, and K = 10). 
# If the sum is larger than 25 (i.e. larger than Z), it starts from the 
# beginning, so S + K = C (i.e. 18 + 10 = 28, and 28 - 26 is equal to 2, which 
# is C).
# For a full chart of how characters combine to form new characters, see [2] 
# here
# The cipher text then becomes:
# GLADOSGLADOSG
# THECAKEISALIE
# -------------
# ZSEFOCKTSDZAK
# 
# Write funtions to both encrypt and decrypt messages given the right key.
# As an optional bonus, decrypt the following message, which has been encrypted
# with a word that I've used in this post:
# HSULAREFOTXNMYNJOUZWYILGPRYZQVBBZABLBWHMFGWFVPMYWAVVTYISCIZRLVGOPGBRAKLUGJUZGLN
# BASTUQAGAVDZIGZFFWVLZSAZRGPVXUCUZBYLRXZSAZRYIHMIMTOJBZFZDEYMFPMAGSMUGBHUVYTSABB
# AISKXVUCAQABLDETIFGICRVWEWHSWECBVJMQGPRIBYYMBSAPOFRIMOLBUXFIIMAGCEOFWOXHAKUZISY
# MAHUOKSWOVGBULIBPICYNBBXJXSIXRANNBTVGSNKR
# As an additional challenge, attempt to pronounce "Vigenère" properly. I think
# it's like "Viche-en-ere", but I'm not entirely sure.
# Retrieve from http://www.reddit.com/r/dailyprogrammer/comments/y5sox/8132012_challenge_88_easy_vigen%C3%A8re_cipher/ 
# on 8-13-2012
#

require 'Benchmark'
require 'test/unit'

def f(p,k,code=:+)
  idx = (p.ord.send(code,k.ord) - 130) % 26 # 130 = 2*"A".ord, 26 = strlen
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[idx]
end

def g(p,k,set,code=:+)
  set[(p.ord.method(code).call(k.ord)-(2*"A".ord))%26]
end

def encode(plain, key, code=:+)
  plain_arr = plain.upcase.split(//)
  key_arr = key.upcase.split(//)
  plain_arr.each_with_index.map do |p,i|
    f(p,key_arr[i%key_arr.length],code)
  end.join
end

def decode(cipher, key, code=:-)
  encode(cipher, key, code)
end

def encode_g(plain, key, code=:+)
  plain_arr = plain.upcase.split(//)
  key_arr = key.upcase.split(//)
  set = ("A".."Z").to_a.join
  plain_arr.each_with_index.map do |p,i|
    g(p,key_arr[i%key_arr.length],set,code)
  end.join
end

def decode_g(cipher, key, code=:-)
  encode_g(cipher, key, code)
end


cipher = "HSULAREFOTXNMYNJOUZWYILGPRYZQVBBZABLBWHMFGWFVPMYWAVVTYISCIZRLVGOPGBRAKLUGJUZGLNBASTUQAGAVDZIGZFFWVLZSAZRGPVXUCUZBYLRXZSAZRYIHMIMTOJBZFZDEYMFPMAGSMUGBHUVYTSABBAISKXVUCAQABLDETIFGICRVWEWHSWECBVJMQGPRIBYYMBSAPOFRIMOLBUXFIIMAGCEOFWOXHAKUZISYMAHUOKSWOVGBULIBPICYNBBXJXSIXRANNBTVGSNKR"
plain = "THECAKEISALIE"
key = "GLADOS"


Benchmark.bmbm do |x|
  x.report("Encode/decode with 'f'") { (0..10000).each { encode(decode(cipher, key),key) } }
  x.report("Encode/decode with 'g'") { (0..10000).each { encode_g(decode_g(cipher, key),key) } }
end

class TestAdd < Test::Unit::TestCase
  def test_encode_decode
    assert_equal(encode(decode("THISISATEST","MYKEY"),"MYKEY"), "THISISATEST")
  end

  def test_decode_encode
    assert_equal(decode(encode("THISISATEST","MYKEY"),"MYKEY"), "THISISATEST")
  end

  def test_encode
    assert_equal(encode("THECAKEISALIE", "GLADOS"), "ZSEFOCKTSDZAK")
  end

  def test_decode
    assert_equal(decode("ZSEFOCKTSDZAK", "GLADOS"), "THECAKEISALIE")
  end

end


