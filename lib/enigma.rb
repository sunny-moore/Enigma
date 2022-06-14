require 'pry'
require 'date'
require './lib/shiftable'

class Enigma
  include Shiftable
  attr_reader :char_set, :key, :date

  def initialize()
    @char_set = ("a".."z").to_a << " "
    @key = nil
    @date = Date.today.strftime("%m%d%y")
  end

  def encrypt(message, key = @key , date = @date)
    check_key(key)
    check_date(date)
    encrypted_msg = ""
    message.downcase.chars.each_with_index do |char, i|
      if @char_set.include?(char) == false
        encrypted_msg += char
      else
        rotated = @char_set.rotate(@char_set.index(char))
        shift_index = get_shift_hash[i % 4 + 1] % 27
        encrypted_msg += rotated[shift_index]
      end
    end
    {:encryption => encrypted_msg, :key => @key[1,5], :date => @date}
  end

  def decrypt(ciphertext, key = @key, date = @date)
    check_key(key)
    check_date(date)
    the_shift = get_shift_hash
    decrypted_msg = ""
    ciphertext.downcase.chars.each_with_index do |char, i|
      if char_set.include?(char) == false
        decrypted_msg += char
      else
        rotated = @char_set.rotate(@char_set.index(char) + 1)
        shift_index = (the_shift[i % 4 + 1] % 27)
        decrypted_msg += rotated[rotated.length - (shift_index + 1)]
      end
    end
    {:decryption => decrypted_msg, :key => @key[1,5], :date => @date}
  end

  def check_key(key)
    if key.nil?
      set_key
    else
      @key = "." + key
    end
  end

  def check_date(date)
    if date.nil?
      @date = Date.today.strftime("%m%d%y")
    else
      @date = date
    end
  end
end
