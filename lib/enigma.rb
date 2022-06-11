require 'pry'
require 'date'

class Enigma
  attr_reader :char_set, :key

  def initialize()
    @char_set = ("a".."z").to_a << " "
    @key = "0.000000"
  end
  def random_number()
    num = rand().round(10)
  end
  def set_key
    str = random_number.to_s[1,6]
    @key = str
  end
  def get_key_hash
    key_hash = Hash.new
    i = 1
    while i < 5
      int_string = @key[i, 2]
      key_hash[i] = int_string.to_i
      i += 1
    end
    key_hash
  end
end
