class Room
  attr_accessor :price, :beds, :guests, :name

  def initialize(options = {})
    self.price = options[:price]
    self.beds  = options[:beds]
    self.guests = []
    self.name = options[:name]
  end

def occupied?
  self.guests.any?
end

def full?
  self.guests.size == self.beds
end

def double?
  self.beds == 2
end

def check_in(guests)
  until full? || guests.empty?
    self.guests << guests.pop
  end
end

def check_out(guest_names)
  self.guests.each { |guest| self.guests.delete(guest) if guest_names.include?(guest.name)  }
end

def guests_pretty_string
  guest_names = guests.map { |guest| guest.name }
  if guest_names.size == 1
    "#{guest_names[0]}."
  else
    "#{guest_names[0..-2].join(", ")} and #{guest_names[-1]}."
  end
end

def occupancy_report
  puts "> Room #{self.name} is occupied by #{guests_pretty_string}"
end

end