def clear_screen(extra="")
  puts `clear`
  puts "
     .         .
    /|________/|
   // /      //|
  |/_/______|//!
  |_________|/
  !         !

╔═════════════════╗
║   Unnecessary   ║   
║    ASCII Art    ║
║      Hotel      ║
║  Staff Computer ║ 
╚═════════════════╝
#{extra}"
end

def arrow
  print "==> "
end

def enter_to_continue
  puts
  print "Press enter to contiue"
  gets 
end

def invalid_input
  clear_screen
  print "Your input was invalid, you will be returned to the previous menu"
  enter_to_continue
end

def main_menu
  clear_screen
  puts "What do you want to do?
check (i)n  guests
check (o)ut guests
check (v)acancies
check (r)evenue
or (q)uit"
  arrow
end

def check_in(hotel)
  check_in_get_number_of_guests_menu
  party_size = gets.chomp.to_i
  (invalid_input;check_in(hotel)) if party_size == 0
  check_in_family_menu
  guests_checking_in = create_guests(gets.chomp.downcase, party_size)
  (invalid_input;check_in) unless (guests_checking_in)
  select_beds(guests_checking_in, hotel)
end

def check_in_get_number_of_guests_menu
  clear_screen
  puts "How many people are checking in?"
  arrow
end

def check_in_family_menu
  clear_screen
  puts "Are they a family? (y)es or (n)o?"
  arrow
end

def create_guests(family, party_size)
  guests = Array.new
  case family
  when 'y'
    family_name = Guest::list_of_last_names.sample
    party_size.times do
      guests.push(Guest.new(last_name: family_name))
    end
    guests
  when 'n'
    party_size.times do
      guests.push(Guest.new)
    end

    guests
  else
    return false
  end
end

def select_beds(guests_checking_in, hotel)
  #binding.pry
  copy_of_guests = guests_checking_in.dup
  room_numbers = []
  until guests_checking_in.empty?
    display_vacancies(hotel.vacancies)
    puts "There are #{guests_checking_in.size} guest(s) left to check in"
    bed_selection_menu
    case gets.chomp.downcase
    when 's'
      room_numbers.push(check_into_room(hotel, Room, guests_checking_in))
    when 'd' 
      room_numbers.push(check_into_room(hotel, DoubleRoom, guests_checking_in))
    when 'h'
      room_numbers.push(check_into_room(hotel, HoneymoonSuite, guests_checking_in))
    else
      invalid_input
      select_beds(guests_checking_in, hotel)
    end
    #binding.pry
  end
  #binding.pry
  clear_screen
  check_in_complete(copy_of_guests, room_numbers)
end

def check_into_room(hotel, room_type, guests_checking_in=0)
  room = hotel.get_vacant_room(room_type)
  if room
    until (room.no_of_beds == room.occupants.size) || guests_checking_in.empty?
      room.check_in(guests_checking_in.pop)
    end
    room.room_number
  else
  end
end

def bed_selection_menu
  puts
  puts "Would our guest(s) like a 
(s)ingle
(d)ouble
or a (h)oneymoon suite?"
puts
end

def check_in_complete(guests_checked_in, rooms_checked_into)
  rooms_checked_into = rooms_checked_into.compact.join(", ")
  puts "#{guests_checked_in.collect{|guest| guest.name}.join(", ")} \nAre now checked in to the following rooms: "
  puts "#{rooms_checked_into}"
  puts "If you forget to wish them a nice stay, management will dock your pay."
  enter_to_continue
end

      ###check out###

def check_out(hotel)
  clear_screen
  check_out_1st_menu(hotel)
  room_number = gets.to_i
  hotel.check_out(room_number)
  puts "Would you like to check guests out of another room? (y)es or (n)o"
  selection = gets.chomp.downcase
  if selection == 'y'
    check_out(hotel)
  end
end

def check_out_1st_menu(hotel)
  puts "The following is a list of every guest and the room they are staying in:"
  hotel.list_occupants_and_room_numbers
  puts "Which room number do you wish to check guests out of?"
end

      ###vacancies###

def display_vacancies(empty_rooms, enter_needed=false)
  clear_screen
  single_rooms = empty_rooms.select{|room_number, room| room.class == Room}.size
  double_rooms = empty_rooms.select{|room_number, room| room.class == DoubleRoom}.size
  honeymoon_suites = empty_rooms.select{|room_number, room| room.class == HoneymoonSuite}.size
  puts "The following number of each type of room that are not yet booked are as follows:
#{single_rooms} single room(s)
#{double_rooms} double room (s)
#{honeymoon_suites} honeymoon suite(s)"
puts
enter_to_continue() if enter_needed
end

      ###display revenue###

def display_revenue(occupied_rooms)
  clear_screen
  single_rooms = occupied_rooms.select{|room_number, room| room.class == Room}.size
  double_rooms = occupied_rooms.select{|room_number, room| room.class == DoubleRoom}.size
  honeymoon_suites = occupied_rooms.select{|room_number, room| room.class == HoneymoonSuite}.size
  puts "The following number of each type of room has paying guests:
#{single_rooms} single room(s) for £#{single_rooms * 15}
#{double_rooms} double room (s) for £#{double_rooms * 25} 
#{honeymoon_suites} honeymoon suite(s) for £#{honeymoon_suites * 65} 

The hotel can expect a total revnue of £#{(single_rooms * 15) + (double_rooms * 25) + (honeymoon_suites * 65)} today"
enter_to_continue
end