def menu
  print `clear`
  puts "*** Welcome, wanderer, to Vault Tec's Wasteland Fallout Shelter Network ***"
  puts
  puts "Please select an option:"
  puts "1. List hotels "
  puts "2. Check in"
  puts "3. Vacate room"
  puts "4. Occupancy report"
  puts "5. Revenue report"
  puts
  puts "0. To quit"
  puts
  print "--> "

  gets.to_i
end

def list_hotels(chain)
  puts
  puts chain.list_hotels
end

def check_in(chain)
  puts
  chain.check_in
end

def vacate_room(chain)
  puts
  chain.vacate_room
end

def occupancy_report(chain)
  puts
  chain.occupancy_report
end

def revenue_report(chain)
  puts
  chain.revenue_report
end


