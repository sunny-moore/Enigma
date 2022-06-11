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
end
