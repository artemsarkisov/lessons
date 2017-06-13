require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_waggon'
require_relative 'passenger_waggon'


@stations = []
@trains   = {}
@routes   = []


def create_station
  puts "Enter the station name"
  name    = gets.chomp
  station = Station.new(name)
  puts "Station #{station.name} was created"
  @stations << station
end


def create_train
  puts "Enter the number of the train"
  number = gets.chomp.to_i
  puts "Enter the type of the train: 1 - passenger train; 2 - cargo train"
  type = gets.chomp.to_i
  case
    when type == 1
      train = PassengerTrain.new(number)
    when type == 2
      train = CargoTrain.new(number)
    else
      puts "Bad input. Choose 1 or 2"
  end
  @trains[train] = train.number
  puts "Train was created!"
end

def create_route
  puts "Enter the number to choose the first station"
  @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }
  first_st = gets.chomp.to_i
  puts "Choose the last station"
  last_st = gets.chomp.to_i
  if @stations[first_st, last_st].empty?
    puts "You need to choose two stations to create a route"
  else
    route = Route.new(@stations[first_st], @stations[last_st])
    puts "Route created! #{route.stations_list}"
    @routes << route
  end
end


def edit_route
  route_choice
  puts "1 - add station; 2 - remove station"
  choice = gets.chomp.to_i
  puts "Choose the station by number"
  @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }
  interim_station = gets.chomp.to_i
  if choice == 1
    @chosen_route.add_station(@stations[interim_station])
  elsif choice == 2
    @chosen_route.remove_station(@stations[interim_station])
  end
end

def assign_route
  train_choice
  route_choice
  @chosen_train.route = @chosen_route
end

def add_waggon
  train_choice
  if @chosen_train.class == PassengerTrain
    waggon = PassengerWaggon.new
  else
    waggon = CargoWaggon.new
  end
  @chosen_train.attach_waggon(waggon)
  puts @chosen_train.waggons
end

def remove_waggon
  train_choice
  @chosen_train.detach_waggon
  puts @chosen_train.waggons
end

def move_forward
  train_choice
  @chosen_train.move_to_next_station
  puts "Moved to station: #{@chosen_train.current_station}"
end

def move_back
  train_choice
  @chosen_train.move_to_previous_station
  puts "Moved to station: #{@chosen_train.current_station}"
end

def list_of_stations
  @stations.each { |station| puts station.name }
end

def trains_current_station
  @trains.each_key do |train|
    @stations.each do |station|
      if station.name == train.current_station
        puts "Station: #{station.name} train: #{train.number}"
      end
    end
  end
end

private
# данные методы необходимы только для вызова некоторых публичных методов

def train_choice
  puts "Choose your train"
  @trains.each_value { |train_number| puts train_number }
  train_number = gets.chomp.to_i
  if @trains.has_value?(train_number)
    @chosen_train = @trains.key(train_number)
    puts "Train was chosen!"
  else
    puts "Wrong train number."
  end
end

def route_choice
  puts "Enter the number of the route"
  @routes.each_with_index { |value, index| puts "#{index} - #{value.stations_list}" }

  route_index = gets.chomp.to_i
  if @routes[route_index] != nil
    @chosen_route = @routes[route_index]
    puts "Route was chosen!"
  else
    puts "Route doesn't exist."
  end
end