require 'pry-byebug'
require_relative 'methods'
require_relative 'chain'
require_relative 'hotel'
require_relative 'room'
require_relative 'person'

chain = Chain.new("Vault Tec's Wasteland Fallout Shelter Network")

hotels = [
  ["Vault 13", "West of Shady Sands, Capital Wasteland, California"],
  ["Vault 101", "North West of Megaton, Washington D.C."],
  ["Vault 111", "Mojave Wasteland"],
  ["Vault 106", "Southeast of Arefu, Capital Wasteland, California"]
]

room_prices = [30.00, 50.00, 15.00, 100.00, 2000.00, 130.00, 85.00, 70.00, 65.00]
beds = [1,2]
rooms = [4,5,6,8,10,12,]

hotels.each do |hotel| 
  chain.add_hotel( name: hotel[0], address: hotel[1], id: hotel[0].split[1].to_i) 
end

chain.hotels.each do |id, hotel| 
  rooms.sample.times { hotel.add_room( price: room_prices.sample, beds: beds.sample)}
end 

response = menu

until response == 0
  case response
    when 1
      list_hotels(chain)
    when 2
      check_in(chain)
      # add option to choose room by price?
    when 3
      vacate_room(chain)
    when 4
      # Occupancy report
    when 5
      # Revenue report
  end

  puts
  puts "Press enter to continue"
  gets

 response = menu

end


binding.pry
'a'