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

end
