require_relative 'menu'

loop do
  Menu.print_menu
  user_input = gets.chomp.to_i
  case user_input
    when 1
      Menu.create_station
    when 2
      Menu.create_train
    when 3
      Menu.create_route
    when 4
      Menu.edit_route
    when 5
      Menu.assign_route
    when 6
      Menu.add_waggon
    when 7
      Menu.remove_waggon
    when 8
      Menu.move_forward
    when 9
      Menu.move_back
    when 10
      Menu.list_of_stations
    when 11
      Menu.trains_current_station
    else
      break
  end
end