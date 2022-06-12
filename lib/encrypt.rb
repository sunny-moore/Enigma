require 'pry'
require 'date'

class Encrypt
  attr_reader :enigma
  
  def initialize()
    @enigma = Enigma.new
  end
end
