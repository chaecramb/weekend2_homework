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

  def check_in
    print `clear`
    puts "Thank you for choosing Vault Tec's Wasteland Fallout Shelter Network"
    puts
    puts list_hotels
    puts
    puts "Please enter the number of the vault you'd like to check in to."
    puts
    print "--> "
    vault = gets.to_i
    until self.hotels.keys.include?(vault)
      puts
      puts "Incorrect entry, please try again."
      print "--> "
      vault = gets.to_i
    end
    hotels[vault].get_guests(:check_in)
  end

  def vacate_room
    print `clear`
    puts list_hotels
    puts
    puts "Please enter the number of the vault you are checking out of."
    puts
    print "--> "
    vault = gets.to_i
    hotels[vault].get_guests(:check_out)
  end

  def occupancy_report
    hotels.values.each { |hotel| hotel.occupancy_report }
  end

  def revenue_report
    hotels.each_value { |hotel| hotel.revenue_report }
  end
end