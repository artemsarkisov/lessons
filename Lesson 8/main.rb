require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'waggon'
require_relative 'cargo_waggon'
require_relative 'passenger_waggon'
require_relative 'module'

class Main
  attr_reader :user_input

  def initialize
    @stations = []
    @trains   = {}
    @routes   = []
    @block    = proc do |waggon, index|
      if waggon.class == PassengerWaggon
        puts "#{index} - #{waggon.class}; Free seats: #{waggon.seats}; Taken seats: #{waggon.occupied_seats}"
      else
        puts "#{index} - #{waggon.class}; Free space: #{waggon.volume}; Occupied space: #{waggon.load_volume}"
      end
    end
  end

  def print_menu
    puts 'Choose action:'
    puts '1 - Create station'
    puts '2 - Create train'
    puts '3 - Create route'
    puts '4 - Edit route'
    puts '5 - Assign route'
    puts '6 - Add waggon'
    puts '7 - Remove waggon'
    puts '8 - Move to next station'
    puts '9 - Move to previous station'
    puts '10 - List all stations'
    puts '12 - Show waggons of the train'
    puts '13 - Detailed station-trains info'
    puts '14 - Take seat/load waggon'
    puts 'ENTER ANY OTHER SYMBOL TO STOP'
  end

  def user_choice
    @user_input = gets.chomp.to_i
    case @user_input
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
    when 12
      show_waggons
    when 13
      trains_on_station
    when 14
      load_waggon
    else
      puts 'Unknown command'
    end
  end

  private

  def create_station
    puts 'Enter the station name'
    name    = gets.chomp
    station = Station.new(name)
    puts "Station #{station.name} was created"
    @stations << station
  rescue => e
    puts e.message
    return
  end

  def create_train
    puts 'Enter the number of the train'
    number = gets.chomp.to_s
    choose_type
    @type == 1 ? train = PassengerTrain.new(number) : train = CargoTrain.new(number)
    @trains[train] = train.number
  rescue => e
    puts e.message
    return
  end

  def choose_type
    puts 'Enter the type of the train: 1 - passenger train; 2 - cargo train'
    @type = gets.chomp.to_i
    raise 'Bad input. Choose 1 or 2.' unless @type.between?(1, 2)
  rescue => e
    puts e.message
    return
  end

  def create_route
    puts 'Enter the number of the first and last stations'
    station_choice
    first_st = @station_index
    station_choice
    last_st = @station_index
    route   = Route.new(@stations[first_st], @stations[last_st])
    @routes << route
  rescue => e
    puts e.message
    return
  end

  def edit_route
    route_choice
    puts '1 - add station; 2 - remove station'
    choice = gets.chomp.to_i
    raise 'Wrong action. Choose 1 or 2' unless choice.between?(1, 2)
    puts 'Choose the station by its number'
    station_choice
    choice == 1 ? @chosen_route.add_station(@chosen_station) : @chosen_route.remove_station(@chosen_station)
  rescue => e
    puts e.message
    return
  end

  def assign_route
    train_choice
    route_choice
    @chosen_train.route = @chosen_route
    @chosen_route.stations_list.first.get_train(@chosen_train)
  rescue => e
    puts e.message
    return
  end

  def add_waggon
    train_choice
    if @chosen_train.class == PassengerTrain
      create_pass_waggon
    elsif @chosen_train.class == CargoTrain
      create_cargo_waggon
    end
    @chosen_train.attach_waggon(@waggon)
  rescue => e
    puts e.message
    return
  end

  def create_pass_waggon
    puts 'Enter the number of the seats'
    seats   = gets.chomp.to_i
    @waggon = PassengerWaggon.new(seats)
  end

  def create_cargo_waggon
    puts 'Enter the volume'
    volume  = gets.chomp.to_i
    @waggon = CargoWaggon.new(volume)
  end

  def remove_waggon
    show_waggons
    waggon_index = gets.chomp.to_i
    raise "Waggon doesn't exist" if @chosen_train.waggons[waggon_index].nil?
    waggon = @chosen_train.waggons[waggon_index]
    @chosen_train.detach_waggon(waggon)
  rescue => e
    puts e.message
    return
  end

  def move_forward
    train_choice
    @chosen_train.current_station.depart(@chosen_train)
    @chosen_train.move_to_next_station
    @chosen_train.current_station.get_train(@chosen_train)
    puts "Moved to station: #{@chosen_train.current_station.name}"
  rescue => e
    puts e.message
    return
  end

  def move_back
    train_choice
    @chosen_train.current_station.depart(@chosen_train)
    @chosen_train.move_to_previous_station
    @chosen_train.current_station.get_train(@chosen_train)
    puts "Moved to station: #{@chosen_train.current_station.name}"
  rescue => e
    puts e.message
    return
  end

  def list_of_stations
    puts @stations.map(&:name)
  end

  def train_choice
    puts 'Choose your train'
    @trains.each_value { |train_number| puts train_number }
    train_number = gets.chomp.to_s
    raise 'Wrong train number' unless @trains.value?(train_number)
    @chosen_train = @trains.key(train_number)
    puts 'Train was chosen!'
  end

  def route_choice
    puts 'Enter the number of the route'
    @routes.each_with_index { |value, index| puts "#{index} - #{value.stations_list}" }
    route_index = gets.chomp.to_i
    raise "Route doesn't exist" if @routes[route_index].nil?
    @chosen_route = @routes[route_index]
    puts 'Route was chosen!'
  end

  def station_choice
    puts 'Choose a station'
    @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }
    @station_index = gets.chomp.to_i
    raise "Station doesn't exist" if @stations[@station_index].nil?
    @chosen_station = @stations[@station_index]
    puts 'Station was chosen.'
  end

  def trains_on_station
    station_choice
    raise 'No trains on this station.' if @chosen_station.trains_list.empty?
    @chosen_station.trains_to_block do |train|
      puts "Train: #{train.number}; Type: #{train.type}; Waggons: #{train.waggons.length}"
    end
  rescue => e
    puts e.message
    return
  end

  def show_waggons
    train_choice
    @chosen_train.waggons_to_block @block
  rescue => e
    puts e.message
    return
  end

  def load_waggon
    waggon_choice
    if @chosen_train.class == CargoTrain
      puts 'Enter the volume to load'
      load_volume = gets.chomp.to_i
      @chosen_train.waggons[@waggon_index].stow(load_volume)
    else
      @chosen_train.waggons[@waggon_index].take_seat
    end
  rescue => e
    puts e.message
    return
  end

  def waggon_choice
    train_choice
    puts 'Choose a waggon'
    @chosen_train.waggons.each_with_index do |waggon, index|
      puts "#{index} - #{waggon}"
    end
    @waggon_index = gets.chomp.to_i
    raise 'No such waggon.' if @chosen_train.waggons[@waggon_index].nil?
  end
end

launcher = Main.new

loop do
  launcher.print_menu
  launcher.user_choice
  break unless launcher.user_input.between?(1, 14)
end
