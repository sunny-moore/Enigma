require 'pry'
require 'date'

class Enigma
  attr_reader :char_set

  def initialize()
    @char_set = ("a".."z").to_a << " "
  end
  def random_number()
    num = rand().round(6)
    # binding.pry
    num
  end
end
