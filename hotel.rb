class Hotel
  attr_accessor :name, :rooms, :id
  attr_reader :address

  def initialize(options = {})
    self.name = options.fetch(:name)
    @address = options.fetch(:address)
    self.rooms = []
    self.id = options.fetch(:id)
  end

  def add_room(options = {})
    self.rooms << Room.new(price: options[:price], beds: options[:beds])
  end

  def empty_rooms
    rooms.select { |room| !room.occupied? }
  end

  def occupied_rooms
    rooms.select { |room| room.occupied? }
  end


  def pretty_string
    "#{self.name} has #{rooms.size} rooms, #{empty_rooms.size} are currently available."
  end

  def available_beds
    empty_rooms.inject(0) { |beds, room| beds += room.beds }
  end

  def check_in(guests)
    empty_rooms.each { |room| room.check_in(guests) }
  end

  def check_out(guest_names)
    binding.pry
    occupied_rooms.each { |room| room.check_out(guest_names) }
  end
# problem with chwckout is that when get guest is called for checkout
# a new guest object is created with that name, so when the room tries
# to delete that object it doesn't effect the original guest

  def create_new_guests(guest_names)
    guest_names.map { |name| Person.new(name: name) }
  end

  def get_guests(value)
    puts
    print "Guest name: "
    response = gets.chomp
    guest_names = []
    until response == ''
      #guests << Person.new(name: response)
      guest_names << response
      print "Next guest (or press enter to continue): "
      response = gets.chomp
    end
    beds = available_beds
    if beds < guest_names.size
      puts
      puts "Sorry #{self.name} only has space left for #{beds} guests."
    else
      if value == :check_in
        guests = create_new_guests(guest_names)
        check_in(guests)
      else
        check_out(guest_names)
        # need to follow this through, to account for name being passed as string
      end
    end
  end



end
