require 'pry'
require 'RSpec'
require 'date'
require 'enigma'
require 'encryptor'

describe Encryptor do
  before :each do
    @encryptor = Encryptor.new
  end
  it "exists" do
    expect(@encryptor).to be_a Encryptor
  end
  it "starts with an Enigma object" do
    expect(@encryptor.enigma).to be_a Enigma
  end
  it "starts with an empty incoming_text variable" do
    expect(@encryptor.incoming_text).to be_a String
    expect(@encryptor.incoming_text).to eq("")
  end
  it "can read in a msg file ('hello world')" do
    #\n means length will be one more than msg
    @encryptor.file_open("message.txt")
    expect(@encryptor.incoming_text).to be_a String
    expect(@encryptor.incoming_text.length).to eq(12)
    expect(@encryptor.incoming_text).to eq("hello world\n")
    expect(File.open("message.txt").count).to eq(1)
  end
  it "starts with an empty outgoing_text variable" do
    expect(@encryptor.outgoing_text).to be_a String
    expect(@encryptor.outgoing_text).to eq("")
  end
  it "starts with an empty encrypt_result hash" do
    expect(@encryptor.encrypt_result).to be_a Hash
    expect(@encryptor.encrypt_result).to eq({})
  end
  it "can encrypt incoming txt and store in encrypt_result" do
    @encryptor.file_open("message.txt")
    @encryptor.encrypt("02715", "040895")
    expect(@encryptor.encrypt_result).to be_a Hash
    expect(@encryptor.encrypt_result[:encryption]).to eq("keder ohulw\n")
    expect(@encryptor.encrypt_result[:key]).to eq("02715")
    expect(@encryptor.encrypt_result[:date]).to eq("040895")
  end
  it "can write in encrypted.txt file ('keder ohulw\n')" do
    #\n means length will be one more than msg
    @encryptor.file_open("message.txt")
    @encryptor.encrypt("02715", "040895")
    @encryptor.file_write("encrypted.txt")
    expect(@encryptor.outgoing_text).to be_a String
    expect(@encryptor.outgoing_text.length).to eq(12)
    expect(@encryptor.outgoing_text).to eq("keder ohulw\n")

    handler = File.open("encrypted.txt", "r")
    expected = handler.read
    handler.close

    expect(expected).to be_a String
    expect(expected.length).to eq(12)
    expect(expected).to eq("keder ohulw\n")
  end
  it "has a start method to open file, encrypt and write file" do
    @encryptor.start("message.txt", "encrypted.txt")

    expect(@encryptor.incoming_text).to eq("hello world\n")
    expect(File.open("message.txt").count).to eq(1)
    expect(@encryptor.outgoing_text).to eq("keder ohulw\n")
    expect(File.readable?("encrypted.txt")).to eq(true)
  end
  it "creates encrypted.txt file with encrypted message" do
    handler = File.open("encrypted.txt", "r")
    expected = handler.read
    handler.close

    expect(expected).to be_a String
    expect(expected.length).to eq(12)
    expect(expected).to eq("keder ohulw\n")
  end
end
