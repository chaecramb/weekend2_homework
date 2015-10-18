class Chain
  attr_accessor :name, :hotels

  def initialize(name)
    self.name = name
    self.hotels = {}
  end

  def add_hotel(options = {})
    hotels[options[:id]] = Hotel.new(name: options[:name], id: options[:id], address: options[:address])
  end

  def list_hotels
    self.hotels.map { |id, hotel| hotel.hotel_pretty_string }
  end

  def get_hotel(value)
    print `clear`
    puts "Thank you for choosing Vault Tec's Wasteland Fallout Shelter Network"
    puts
    puts list_hotels
    puts
    puts "Please enter the number of the vault you'd like to #{value == :check_in ? "check in to" : "check out off"}."
    puts
    print "--> "
    hotel_id = gets.to_i
    until self.hotels.keys.include?(hotel_id)
      puts
      puts "Incorrect entry, please try again."
      print "--> "
      hotel_id = gets.to_i
    end
    hotel_id
  end

  def check_in
    hotel_id = get_hotel(:check_in)
    hotels[hotel_id].check_in
  end

  def vacate_room
    hotel_id = get_hotel(:check_out)
    hotels[hotel_id].check_out
  end

  def occupancy_report
    hotels.values.each { |hotel| hotel.occupancy_report }
  end

  def revenue_report
    hotels.each_value { |hotel| hotel.revenue_report }
  end
end