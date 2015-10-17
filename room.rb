class Room
  attr_accessor :price, :beds, :guests

  def initialize(options = {})
    self.price = options[:price]
    self.beds  = options[:beds]
    self.guests = []
  end

def occupied?
  self.guests.any?
end

def full?
  self.guests.size == self.beds
end

def check_in(guests)
  until full? || guests.empty?
    self.guests << guests.pop
  end
end

def check_out(guest_names)
    self.guests.each { |guest| self.guests.delete(guest) if guest_names.include?(guest.name)  }
end

end