require 'pry-byebug'

require_relative 'hotel'
require_relative 'room'
require_relative 'guest'
require_relative 'menu'

hotel = Hotel.new(name: "The Unnecessary ASCII Art Hotel", single_rooms: 8, double_rooms: 4, honeymoon_suites: 2)

#binding.pry

menu_selection = ''
until menu_selection == 'q'
  main_menu
  case menu_selection = gets.chomp.downcase
  when 'i'
    check_in(hotel)
  when 'o'
    check_out(hotel)
  when 'v'
    display_vacancies(hotel.vacancies, true)
  when 'r'
    display_revenue(hotel.occupied)
  when 'q'
    nil
  else
    invalid_input
  end
  main_menu
end

#binding.pry;''