#!/usr/bin/env ruby

freq = { 
'a' => 8.167,  
'b' => 1.492,
'c' => 2.782,
'd' => 4.253,
'e' => 12.702,
'f' => 2.228,
'g' => 2.015,
'h' => 6.094, 
'i' => 6.966,
'j' => 0.153,
'k' => 0.747,
'l' => 4.025,
'm' => 2.406,
'n' => 6.749,
'o' => 7.507,
'p' => 1.929,
'q' => 0.095,
'r' => 5.987,
's' => 6.327,
't' => 9.056,
'u' => 2.758,
'v' => 1.037,
'w' => 2.365,
'x' => 0.150,
'y' => 1.974,
'z' => 0.074
}

word_lens = (1..12).to_a  #=> word lengths can be 1-12 chars
sent_lens = (3..8).to_a   #=> sentence lengths can be 3-8 words

# Convert frequency table into scrabble-like bag of letters
# with a lot more A's and E's according to the frequency table
# above, retrieved from wikipedia.
letters = []
freq.keys.each do  |c|
  letters.concat([c].cycle((freq[c]*2).ceil).to_a)
end

punctuation = Array.new(100) { ". " }
(0...15).each { |i| punctuation[i] << "\n" } #=> 15% of punctuation is newline
(0...7).each { |i| punctuation[i] << "\n" }  #=> 50% of those are also paragraph break

def word(letters, word_lens)
  letters.sample(word_lens.sample).join
end

def sent(letters, word_lens, sent_lens, punctuation)
  words = (1..sent_lens.sample).map { |_| word(letters, word_lens) }
  words.first.capitalize!
  words.last << punctuation.sample
  words.join(' ')
end

(0...15).each { printf sent(letters, word_lens, sent_lens, punctuation) }
puts ""
