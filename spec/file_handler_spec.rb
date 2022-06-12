require 'pry'
require 'RSpec'
require 'date'
require 'file_handler'

describe FileHandler do
  it "can open a file and return file contents" do
    expected = FileHandler.open("message.txt")
    expect(expected).to eq("hello world\n")
    expect(File.open("message.txt").count).to eq(1)
  end
  it "can write to a file and return file contents" do
    expected = FileHandler.write("encrypted.txt", "keder ohulw\n")
    expect(expected).to eq("keder ohulw\n")
    expect(File.readable?("encrypted.txt")).to eq(true)
  end
  it "creates encrypted.txt file with encrypted message" do
    #Tests that an actual file was created with expected msg
    handler = File.open("encrypted.txt", "r")
    expected = handler.read
    handler.close

    expect(expected).to be_a String
    expect(expected.length).to eq(12)
    expect(expected).to eq("keder ohulw\n")
  end
end
