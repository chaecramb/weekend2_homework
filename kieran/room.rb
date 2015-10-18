class Room

  attr_reader :price, :room_number, :no_of_beds
  attr_accessor :occupants

  def initialize(room_number)
    @room_number = room_number
    @price = 15
    @no_of_beds = 1
    self.occupants = Array.new
  end

  def check_in(person)
    person.in_room = self.room_number
    occupants.push(person)
  end

  def check_out
    occupants.clear
  end

  def occupied?
    occupants.any?
  end

end


class DoubleRoom < Room

  def initialize(room_number)
    super(room_number)
    @price = 25
    @no_of_beds = 2
  end

end

class HoneymoonSuite < Room

  def initialize(room_number)
    super(room_number)
    @price = 65
    @no_of_beds = 2
  end

end