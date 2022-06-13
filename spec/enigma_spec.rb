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
    it "starts with an default key = nil" do
      expect(@cipher.key).to eq(nil)
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
    it "can calculate offset based on date and return a hash of integer key/value pairs" do
      @cipher.set_key
      expected = @cipher.get_offset_hash
      expect(expected).to be_a Hash
      expect(expected.length).to eq(4)
      expect(expected[1]).to be_a Integer
      expect(expected[2]).to be_a Integer
      expect(expected[3]).to be_a Integer
      expect(expected[4]).to be_a Integer
    end
    it "can return a shift hash based on key and offset hashes" do
      @cipher.set_key
      expected = @cipher.get_shift_hash
      expect(expected).to be_a Hash
      expect(expected.length).to eq(4)
      expect(expected[1]).to be_a Integer
      expect(expected[2]).to be_a Integer
      expect(expected[3]).to be_a Integer
      expect(expected[4]).to be_a Integer
    end
    it "can encrypt a message with given key and date" do
      expected = @cipher.encrypt("hello world", "02715", "040895")
      expect(expected[:encryption]).to eq("keder ohulw")
      expect(expected[:key]).to eq("02715")
      expect(expected[:date]).to eq("040895")
    end
    it "can encrypt a message with only a key (use todays date)" do
      expected = @cipher.encrypt("hello world", "02715")
      expect(expected[:encryption].length).to eq(11)
      expect(expected[:key]).to eq("02715")
      expect(expected[:date]).to eq(Date.today.strftime("%m%d%y"))
    end
    it "can encrypt a message (random key and use todays date)" do
      expected = @cipher.encrypt("hello world")
      key = @cipher.key[1, 5]
      date = Date.today.strftime("%m%d%y")
      decrypted = @cipher.decrypt(expected[:encryption], key, date)
      expect(expected[:encryption].length).to eq(11)
      expect(expected[:key]).to eq(key)
      expect(expected[:date]).to eq(Date.today.strftime("%m%d%y"))
      expect(decrypted[:decryption]).to eq("hello world")
    end
    it "encrypts characters not in the character set as themselves" do
      expected = @cipher.encrypt("hello world!", "02715", "040895")
      expect(expected[:encryption]).to eq("keder ohulw!")
    end
    it "encrypts capital letters as lowercase" do
      expected = @cipher.encrypt("Hello World", "02715", "040895")
      expect(expected[:encryption]).to eq("keder ohulw")
    end
    it "can decrypt a message with given key and date" do
      expected = @cipher.decrypt("keder ohulw", "02715", "040895")
      expect(expected[:decryption]).to eq("hello world")
      expect(expected[:key]).to eq("02715")
      expect(expected[:date]).to eq("040895")
    end
    it "can decrypt a message w/ given key(use today date)" do
      encrypted = @cipher.encrypt("hello world")
      key = @cipher.key[1, 5]

      expected = @cipher.decrypt(encrypted[:encryption], key)
      expect(expected[:decryption]).to eq("hello world")
      expect(expected[:key]).to eq(key)
      expect(expected[:date]).to eq(Date.today.strftime("%m%d%y"))
    end
    it "decrypts characters not in the character set as themselves" do
      expected = @cipher.decrypt("keder ohulw!", "02715", "040895")
      expect(expected[:decryption]).to eq("hello world!")
    end
    it "decrypts capital letters as lowercase" do
      expected = @cipher.decrypt("Keder Ohulw", "02715", "040895")
      expect(expected[:decryption]).to eq("hello world")
    end
end
