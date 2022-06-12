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
  it "starts with an empty incoming_text variable" do
    expect(@encrypt.incoming_text).to be_a String
    expect(@encrypt.incoming_text).to eq("")
  end
  it "can read in a msg file ('hello world')" do
    #\n means length will be one more than msg
    @encrypt.file_open("message.txt")
    expect(@encrypt.incoming_text).to be_a String
    expect(@encrypt.incoming_text.length).to eq(12)
  end

end
