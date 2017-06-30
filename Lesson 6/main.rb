require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_waggon'
require_relative 'passenger_waggon'
require_relative 'module'

class Main

  def initialize
    @stations = []
    @trains   = {}
    @routes   = []
  end

  def print_menu
    loop do
      puts "Choose action:"
      puts "1 - Create station"
      puts "2 - Create train"
      puts "3 - Create route"
      puts "4 - Edit route"
      puts "5 - Assign route"
      puts "6 - Add waggon"
      puts "7 - Remove waggon"
      puts "8 - Move to next station"
      puts "9 - Move to previous station"
      puts "10 - List all stations"
      puts "11 - Show trains on stations"
      puts "12 - Show waggons of the train"
      puts "ENTER ANY OTHER SYMBOL TO STOP"

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
        when 12
          show_waggons
        else
          break
      end
    end
  end

  private

  def create_station
    puts "Enter the station name"
    name    = gets.chomp
    station = Station.new(name)
    puts "Station #{station.name} was created"
    @stations << station

  rescue => e
    puts e.message
    create_station
  end


  def create_train
    puts "Enter the number of the train"
    number = gets.chomp.to_s
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

  rescue => e
    puts e.message
    create_train
  end

  def create_route
    puts "Enter the number to choose the first station"
    @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }
    first_st = gets.chomp
    puts "Enter the number to choose the last station"
    last_st = gets.chomp
    if first_st.empty? || last_st.empty?
      puts "You need to choose two stations to create a route"
    else
      route = Route.new(@stations[first_st.to_i], @stations[last_st.to_i])
      puts "Route created! #{route.stations_list}"
      @routes << route
    end

  rescue => e
    puts e.message
    create_route
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

  rescue => e
    puts e.message
    return
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
    puts "Attached one waggon."

  rescue => e
    puts e.message
    add_waggon
  end

  def remove_waggon
    train_choice
    raise "The train has no waggons" if @chosen_train.waggons.empty?
    @chosen_train.waggons.each_with_index { |waggon, index| puts "#{index} - #{waggon}" }
    waggon_index = gets.chomp.to_i
    raise "The waggon doesn't exist" if @chosen_train.waggons[waggon_index].nil?
    waggon = @chosen_train.waggons[waggon_index]
    @chosen_train.detach_waggon(waggon)
    puts "Detached one waggon."

  rescue => e
    puts e.message
    return
  end

  def move_forward
    train_choice
    @chosen_train.move_to_next_station
    puts "Moved to station: #{@chosen_train.current_station}"

  rescue => e
    puts e.message
    return
  end

  def move_back
    train_choice
    @chosen_train.move_to_previous_station
    puts "Moved to station: #{@chosen_train.current_station}"

  rescue => e
    puts e.message
    return
  end

  def list_of_stations
    @stations.each { |station| puts station.name }
  end

  def trains_current_station
    @trains.each_key do |train|
      @stations.each do |station|
        if station == train.current_station
          puts "Station: #{station.name} train: #{train.number}"
        end
      end
    end
  end

  def train_choice
    puts "Choose your train"
    @trains.each_value { |train_number| puts train_number }
    train_number = gets.chomp.to_s
    raise "Wrong train number" unless @trains.has_value?(train_number)
    @chosen_train = @trains.key(train_number)
    puts "Train was chosen!"

  rescue => e
    puts e.message
    train_choice
  end

  def route_choice
    puts "Enter the number of the route"
    @routes.each_with_index { |value, index| puts "#{index} - #{value.stations_list}" }

    route_index = gets.chomp.to_i
    raise "Route doesn't exist" if @routes[route_index].nil?
    @chosen_route = @routes[route_index]
    puts "Route was chosen!"

  rescue => e
    puts e.message
    route_choice
  end

  def show_waggons
    train_choice
    if @chosen_train.waggons.empty?
      puts "The train has now waggons."
    else
      puts @chosen_train.waggons
    end
  end

end

launcher = Main.new

launcher.print_menu