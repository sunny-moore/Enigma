require 'pry'
require 'RSpec'
require 'enigma'

describe Enigma do
    before :each do
      @cipher = Enigma.new()
    end
    it "exists" do
      expect(@cipher).to be_a Enigma
    end
    it "starts with an default string key" do
      expect(@cipher.key).to eq("0.000000")
    end
    it "has a stored character set" do
      expect(@cipher.char_set).to be_a Array
      expect(@cipher.char_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
        "x", "y", "z", " "])
    end
    it "can generate a random decimal float ex: 0.012345" do
      #There should be 10 numbers after the decimal to allow for a leading or trailing zero. We will use first 5
      expect(@cipher.random_number).to be_a Float
      expect(@cipher.random_number).to be < 1
      expect(@cipher.random_number).to be > 0
    end
    it "can set the key variable to a string version of random number" do
      #ex: ".01234. I want the decimal"
      @cipher.set_key
      expect(@cipher.key).to be_a String
      expect(@cipher.key[0]).to eq(".")
      expect(@cipher.key.length).to be = 6
    end
    it "can return a hash with 4 integer values from key" do
      expect(@cipher.get_key_hash).to be_a Hash
      expect(@cipher.get_key_hash.length).to eq(4)
      expect(@cipher.get_key_hash[1]).to be_a Integer
      expect(@cipher.get_key_hash[2]).to be_a Integer
      expect(@cipher.get_key_hash[3]).to be_a Integer
      expect(@cipher.get_key_hash[4]).to be_a Integer
    end
end
