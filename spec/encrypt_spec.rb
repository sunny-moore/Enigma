require 'pry'
require 'RSpec'
require 'date'
require 'enigma'
require 'encrypt'

describe Encrypt do
  before :each do
    @encrypt = Encrypt.new
  end
  it "exists" do
    expect(@encrypt).to be_a Encrypt
  end
  it "starts with an Enigma object" do
    expect(@encrypt.enigma).to be_a Enigma
  end
end
