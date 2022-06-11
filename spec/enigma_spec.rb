require 'pry'
require 'RSpec'
require 'date'
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
    it "starts with a default date of today in MMDDYY" do
      expect(@cipher.date).to eq(Date.today.strftime("%m%d%y"))
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
      expect(@cipher.key.length).to eq(6)
    end
    it "can return a hash with 4 integer values from key" do
      @cipher.set_key
      expected = @cipher.get_key_hash
      expect(expected).to be_a Hash
      expect(expected.length).to eq(4)
      expect(expected[1]).to be_a Integer
      expect(expected[2]).to be_a Integer
      expect(expected[3]).to be_a Integer
      expect(expected[4]).to be_a Integer
    end
end
