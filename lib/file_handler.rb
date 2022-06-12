require 'pry'

module FileHandler

  def open(filename)
    handler = File.open(filename, "r")
    @incoming_text = handler.read
    handler.close
    @incoming_text
  end

  def write(filename, message)
    writer = File.open(filename, "w")
    writer.write(message)
    writer.close
    message
  end
end
