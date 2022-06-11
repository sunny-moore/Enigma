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
end
