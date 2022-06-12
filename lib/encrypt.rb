require 'pry'
require 'date'

class Encrypt
  attr_reader :enigma, :incoming_text

  def initialize()
    @enigma = Enigma.new
    @incoming_text = ""
  end
  def file_open
    handler = File.open(ARGV[0], "r")
    @incoming_text = handler.read
    handler.close
  end
end
