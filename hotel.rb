class Hotel
  attr_accessor :name, :rooms, :id, :guests, :number_of_rooms
  attr_reader :address

  def initialize(options = {})
    self.name = options.fetch(:name)
    @address = options.fetch(:address)
    self.rooms = []
    self.id = options.fetch(:id)
    self.guests = 0
    self.number_of_rooms = 0
  end

  def add_room(options = {})
    self.number_of_rooms += 1
    self.rooms << Room.new(price: options[:price], beds: options[:beds], name: self.number_of_rooms)
  end

  def empty_rooms
    rooms.select { |room| !room.occupied? }
  end

  def occupied_rooms
    rooms.select { |room| room.occupied? }
  end

  def rooms_available_pretty_string(doubles_available, singles_available)
    
    doubles = if doubles_available == 1
      "is 1 double room"
    else
      "are #{doubles_available} double rooms"
    end

    singles = if singles_available == 1
      "1 single room"
    else
      "#{singles_available} single rooms"
    end

    puts "There #{doubles} and #{singles} available."
  end

  def doubles_available
    self.empty_rooms.inject(0) { |count, room| room.double? ? count += 1 : count }
  end

  def singles_available
    self.empty_rooms.inject(0) { |count, room| !room.double? ? count += 1 : count }
  end


  def hotel_pretty_string
    "#{self.name} has #{rooms.size} rooms, #{empty_rooms.size} are currently available."
  end

  def available_beds
    empty_rooms.inject(0) { |beds, room| beds += room.beds }
  end

  def check_in
    guest_names = get_guests
    beds = available_beds
    if beds < guest_names.size
      puts
      puts "Sorry #{self.name} only has space left for #{beds} guests."
    else
      guests = create_new_guests(guest_names)
      self.guests += guests.size
      empty_rooms.each { |room| room.check_in(guests) }
    end
  end

  def check_out(guest_names)
    binding.pry
    occupied_rooms.each { |room| room.check_out(guest_names) }
  end

  def create_new_guests(guest_names)
    guest_names.map { |name| Person.new(name: name) }
  end

  def get_guests
    puts
    print "Guest name: "
    response = gets.chomp
    guest_names = []
    until response == ''
      guest_names << response
      print "Next guest (or press enter to continue): "
      response = gets.chomp
    end
    guest_names
  end

  def occupancy_report
    puts "#{self.name} currently has #{self.guests} guests."
    rooms_available_pretty_string(doubles_available, singles_available)
    occupied_rooms.each { |room| room.occupancy_report }
    puts
  end

  def revenue_report
    daily_revenue = occupied_rooms.inject(0) { |revenue, room| revenue += room.price }
    puts "#{self.name}: daily revenue: #{daily_revenue}"
  end

end
