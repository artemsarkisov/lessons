require_relative 'interface'
require_relative 'menu'

loop do
  Menu.print

  user_input = gets.chomp.to_i
  case user_input
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      edit_route
    when 5
      assign_route
    when 6
      add_waggon
    when 7
      remove_waggon
    when 8
      move_forward
    when 9
      move_back
    when 10
      list_of_stations
    when 11
      trains_current_station
    else
      break
  end
end