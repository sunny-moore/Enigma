require 'pry'
require 'date'

class Enigma
  attr_reader :char_set, :key, :date

  def initialize()
    @char_set = ("a".."z").to_a << " "
    @key = nil
    @date = Date.today.strftime("%m%d%y")
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
      key_hash[i] = @key[i, 2].to_i
      i += 1
    end
    key_hash
  end

  def get_offset_hash
    num = date.to_i ** 2
    str = num.to_s[-4, 4]
    offset_hash = Hash.new
    i = 1
    while i < 5
      offset_hash[i] = str[i-1].to_i
      i += 1
    end
    offset_hash
  end

  def get_shift_hash
    shift_hash = Hash.new
    key_hash = get_key_hash
    offset_hash = get_offset_hash
    i = 1
    while i < 5
      shift_hash[i] = key_hash[i] + offset_hash[i]
      i += 1
    end
    shift_hash
  end
  def encrypt(message, key = @key , date = @date)
    @date = date
    @key = key
    check_key(@key)
    check_date(@date)
    the_shift = get_shift_hash
    encrypted_msg = ""
    message.downcase.chars.each_with_index do |char, i|
      if char_set.include?(char) == false
        encrypted_msg += char
      else
        rotated = @char_set.rotate(@char_set.index(char))
        shift_index = the_shift[i % 4 + 1] % 27
        encrypted_msg += rotated[shift_index]
      end
    end
    {:encryption => encrypted_msg, :key => @key[1,5], :date => @date}
  end

  def decrypt(ciphertext, key = @key, date = @date)
    @date = date
    @key = key
    check_key(@key)
    check_date(@date)
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
