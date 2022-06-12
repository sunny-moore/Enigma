require 'pry'

module FileHandler

  def self.open(filename = ARGV[0])
    handler = File.open(filename, "r")
    @incoming_text = handler.read
    handler.close
    @incoming_text
  end
end
