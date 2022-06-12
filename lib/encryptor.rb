require 'pry'
require 'date'
require './lib/enigma'

class Encryptor
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

  def start(incoming_file = ARGV[0], outgoing_file = ARGV[1])
    file_open(incoming_file)
    encrypt(key = "02715", date = "040895")
    file_write(outgoing_file)
  end
  def file_open(filename)
    # binding.pry
    handler = File.open(filename, "r")
    @incoming_text = handler.read
    handler.close
  end

  def encrypt(key, date)
    @encrypt_result = @enigma.encrypt(@incoming_text, key, date)
    @outgoing_text = @encrypt_result[:encryption]
  end

  def file_write(filename)
    writer = File.open(filename, "w")
    writer.write(@outgoing_text)
    writer.close
  end
end
