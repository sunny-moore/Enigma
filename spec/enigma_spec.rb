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
    it "has a stored character set" do
      expect(@cipher.char_set).to be_a Array
      expect(@cipher.char_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
        "x", "y", "z", " "])
    end
    it "can generate a random decimal float ex: 0.012345" do
      #There should be 6 numbers after the decimal to allow for a leading or trailing zero
      expect(@cipher.random_number).to be_a Float
      expect(@cipher.random_number).to be < 1
      expect(@cipher.random_number).to be > 0
      expect(@cipher.random_number.to_s.length).to be <= 8
      expect(@cipher.random_number.to_s.length).to be >=7
    end
end
