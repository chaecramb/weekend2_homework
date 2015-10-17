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
    self.hotels.map { |id, hotel| hotel.pretty_string }
  end

  def check_in
    print `clear`
    puts "Thank you for choosing Vault Tec's Wasteland Fallout Shelter Network"
    puts
    puts list_hotels
    puts
    puts "Please enter the number of the vault you'd like to check in to."
    # throws error if you don't enter a vault
    # chain.rb:27:in `check_in': undefined method `get_guests' for nil:NilClass
    puts
    print "--> "
    vault = gets.to_i
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

end