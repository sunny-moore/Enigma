require 'pry'
require 'RSpec'
require 'date'
require 'enigma'
require 'decryptor'

describe Decryptor do
  before :each do
    @decryptor = Decryptor.new
  end
  it "exists" do
    expect(@decryptor).to be_a Decryptor
  end
  it "starts with an Enigma object" do
    expect(@decryptor.enigma).to be_a Enigma
  end
  it "starts with an empty incoming_text variable" do
    expect(@decryptor.incoming_text).to be_a String
    expect(@decryptor.incoming_text).to eq("")
  end
  it "starts with an empty outgoing_text variable" do
    expect(@decryptor.outgoing_text).to be_a String
    expect(@decryptor.outgoing_text).to eq("")
  end
  it "starts with an empty decrypt_result hash" do
    expect(@decryptor.decrypt_result).to be_a Hash
    expect(@decryptor.decrypt_result).to eq({})
  end

  context 'file_handler module methods' do
    it "can read in a encrypted file ('keder ohulw')" do
      #\n means length will be one more than msg
      @decryptor.open("encrypted.txt")
      expect(@decryptor.incoming_text).to be_a String
      expect(@decryptor.incoming_text.length).to eq(12)
      expect(@decryptor.incoming_text).to eq("keder ohulw\n")
      expect(File.open("encrypted.txt").count).to eq(1)
    end
    it "can decrypt incoming txt and store in decrypt_result" do
      @decryptor.open("encrypted.txt")
      @decryptor.decrypt("02715", "040895")
      expect(@decryptor.decrypt_result).to be_a Hash
      expect(@decryptor.decrypt_result[:decryption]).to eq("hello world\n")
      expect(@decryptor.decrypt_result[:key]).to eq("02715")
      expect(@decryptor.decrypt_result[:date]).to eq("040895")
    end
    it "can write in decrypted.txt file ('hello world\n')" do
      #\n means length will be one more than msg
      @decryptor.open("encrypted.txt")
      @decryptor.decrypt("02715", "040895")
      @decryptor.write("decrypted.txt", @decryptor.outgoing_text)
      expect(@decryptor.outgoing_text).to be_a String
      expect(@decryptor.outgoing_text.length).to eq(12)
      expect(@decryptor.outgoing_text).to eq("hello world\n")

      handler = File.open("decrypted.txt", "r")
      expected = handler.read
      handler.close

      expect(expected).to be_a String
      expect(expected.length).to eq(12)
      expect(expected).to eq("hello world\n")
    end
    it "has a start method to open file, decrypt and write file" do
      @decryptor.start("encrypted.txt", "decrypted.txt", "02715", "040895")

      expect(@decryptor.incoming_text).to eq("keder ohulw\n")
      expect(File.open("encrypted.txt").count).to eq(1)
      expect(@decryptor.outgoing_text).to eq("hello world\n")
      expect(File.readable?("decrypted.txt")).to eq(true)
    end
    it "creates decrypted.txt file with decrypted message" do
      handler = File.open("decrypted.txt", "r")
      expected = handler.read
      handler.close

      expect(expected).to be_a String
      expect(expected.length).to eq(12)
      expect(expected).to eq("hello world\n")
    end
  end
end
