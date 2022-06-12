require 'pry'
require 'date'

class Encrypt
  attr_reader :enigma,
              :incoming_text,
              :outgoing_text,
              :encrypt_result

  def initialize()
    @enigma = Enigma.new
    @incoming_text = ""
    @outgoing_text = ""
    @encrypt_result = Hash.new
  end
  def file_open(filename = ARGV[0])
    handler = File.open(filename, "r")
    @incoming_text = handler.read
    handler.close
  end
  def encryptor
    @outgoing_text = @enigma.encrypt(@incoming_text)[:encryption]
  end
end
