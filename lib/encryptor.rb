require 'pry'
require 'date'
require './lib/enigma'
require './lib/file_handler'

class Encryptor
  include FileHandler

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
    @incoming_text = open(incoming_file)
    encrypt(key = "02715", date = "040895")
    write(outgoing_file, @outgoing_text)
  end

  def encrypt(key, date)
    @encrypt_result = @enigma.encrypt(@incoming_text, key, date)
    @outgoing_text = @encrypt_result[:encryption]
  end
end
