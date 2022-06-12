require 'pry'
require 'date'
require './lib/enigma'
require './lib/file_handler'

class Decryptor
  include FileHandler

  attr_reader :enigma,
              :incoming_text,
              :outgoing_text,
              :decrypt_result

  def initialize()
    @enigma = Enigma.new
    @incoming_text = ""
    @outgoing_text = ""
    @decrypt_result = Hash.new
  end

  def start(incoming_file = ARGV[0], outgoing_file = ARGV[1])
    @incoming_text = open(incoming_file)
    decrypt(key = "02715", date = "040895")
    write(outgoing_file, @outgoing_text)
  end

  def decrypt(key, date)
    @decrypt_result = @enigma.decrypt(@incoming_text, key, date)
    @outgoing_text = @decrypt_result[:decryption]
  end
end
