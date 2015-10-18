class Hotel

  attr_accessor :rooms
  attr_reader :name

  def initialize(options={})
    room_number = 1
    @rooms = Hash.new
    @name = options.fetch(:name)
    if options.has_key?(:single_rooms)
      options[:single_rooms].times do
        self.rooms[room_number] = Room.new(room_number)
        room_number += 1
      end
    end

    if options.has_key?(:double_rooms)
      options[:double_rooms].times do
        self.rooms[room_number] = DoubleRoom.new(room_number)
        room_number += 1
      end
    end

    if options.has_key?(:honeymoon_suites) 
      options[:honeymoon_suites].times do
        self.rooms[room_number] = HoneymoonSuite.new(room_number)
        room_number += 1
      end
    end
  end

  def vacancies
    rooms.reject{|room_number, room| room.occupied?}
  end

  def occupied
    rooms.select{|room_number, room| room.occupied?}
  end

  def is_this_room_occupied?(room_number)
    rooms[room_number].occupied?
  end

  def get_vacant_room(room_type)
    empty_room = rooms.detect{|room_number, room| (room.class == room_type) && not(room.occupied?)}
    empty_room[1] if empty_room
  end

  def list_occupants_and_room_numbers
    rooms.each do |room_number, room|
      if room.occupied?
        occupants = room.occupants.collect{|person| person.name}.join(", ")
        print "#{room_number}\t#{occupants}\n"
      end
    end
  end

  def check_out(room_number)
    rooms[room_number].check_out
  end

end