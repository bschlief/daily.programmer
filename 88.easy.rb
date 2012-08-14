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

plain = "THECAKEISALIE"
key = "GLADOS"

def f(p,k,code=:+)
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[(p.ord.method(code).call(k.ord)-(2*"A".ord))%26]
end

def encode(plain, key, code)
  plain_arr = plain.upcase.split(//)
  key_arr = key.upcase.split(//)
  plain_arr.map do |p|
    k=key_arr.first
    key_arr.rotate!
    f(p,k,code)  
  end.join
end

puts plain
puts encode(plain,key, :+)

cipher = "HSULAREFOTXNMYNJOUZWYILGPRYZQVBBZABLBWHMFGWFVPMYWAVVTYISCIZRLVGOPGBRAKLUGJUZGLNBASTUQAGAVDZIGZFFWVLZSAZRGPVXUCUZBYLRXZSAZRYIHMIMTOJBZFZDEYMFPMAGSMUGBHUVYTSABBAISKXVUCAQABLDETIFGICRVWEWHSWECBVJMQGPRIBYYMBSAPOFRIMOLBUXFIIMAGCEOFWOXHAKUZISYMAHUOKSWOVGBULIBPICYNBBXJXSIXRANNBTVGSNKR"
key = "BEGINNING"

puts encode(cipher, key, :-)

