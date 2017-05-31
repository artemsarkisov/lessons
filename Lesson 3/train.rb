class Station

  attr_reader :trains_list

  def initialize(name)
    @name        = name
    @trains_list = []
  end

  def get_train(train)
    @trains_list << train
  end

  def trains_by_number
    @trains_list.each do |i|
      puts "Train ##{i.number}"
    end
  end

  def trains_by_type(type)
    filtered = @trains_list.select { |train| train.type == type }
    puts "#{filtered.length} #{type} trains"
  end

  def depart(train)
    @trains_list.delete(train)
  end
end

class Route
  attr_reader :stations_list

  def initialize(first_st, last_st)
    @stations_list = [first_st, last_st]
  end

  def add_station(interim_st)
    @stations_list.insert(-2, interim_st)
  end

  def remove_station(interim_st)
    @stations_list.delete(interim_st)
  end
end

class Train

  attr_reader :number, :current_speed, :waggons, :type, :current_station, :previous_station, :next_station

  def initialize(number, type, waggons)
    @number        = number
    @type          = type
    @waggons       = waggons
    @current_speed = 0
  end

  def speed_up=(speed)
    @current_speed += speed
  end

  def brake
    @current_speed = 0
  end

  def attach_waggon
    @waggons += 1 if @current_speed == 0
  end

  def detach_waggon
    if @waggons == 0
      puts "The train has no waggons"
    else
      @waggons -= 1 if @current_speed == 0
    end
  end

  def route=(route)
    @route            = route
    @current_station  = @route.stations_list[0]
    @next_station     = @route.stations_list[1]
    @previous_station = nil
  end

  def move_to_next_station
    puts "It's the last station" if @current_station == @route.stations_list.last
    station_index     = @route.stations_list.index(@current_station) + 1
    @next_station     = @route.stations_list[station_index + 1]
    @previous_station = @current_station
    @current_station  = @route.stations_list[station_index]
  end

  def move_to_previous_station
    puts "It's the first station" if @current_station == @route.stations_list.first
    station_index    = @route.stations_list.index(@current_station) - 1
    @next_station    = @current_station
    @next_station    = @route.stations_list[station_index - 1]
    @current_station = @route.stations_list[station_index]
  end
end
