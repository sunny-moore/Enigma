require 'pry'

module Shiftable

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
end
