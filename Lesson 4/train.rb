class Train

  attr_reader :current_speed, :current_station, :previous_station, :next_station, :route, :number

  def initialize(number)
    @number        = number
    @current_speed = 0
  end

  def speed_up=(speed)
    @current_speed += speed
  end

  def brake
    @current_speed = 0
  end

  def route=(route)
    @route            = route
    @current_station  = @route.stations_list[0]
    @next_station     = @route.stations_list[1]
    @previous_station = nil
  end

  def move_to_next_station
    if @current_station.nil?
      puts "Can't move, the train has no route!"
    elsif @current_station == @route.stations_list.last
      puts "It's the last station"
    else
      station_index     = @route.stations_list.index(@current_station) + 1
      @next_station     = @route.stations_list[station_index + 1]
      @previous_station = @current_station
      @current_station  = @route.stations_list[station_index]
    end
  end

  def move_to_previous_station
    if @current_station.nil?
      puts "Can't move, the train has no route!"
    elsif @current_station == @route.stations_list.first
      puts "It's the first station"
    else
      station_index    = @route.stations_list.index(@current_station) - 1
      @next_station    = @current_station
      @next_station    = @route.stations_list[station_index - 1]
      @current_station = @route.stations_list[station_index]
    end
  end

  def attach_waggon(waggon)
    @waggons = []
    @waggons << waggon if @current_speed == 0
    puts "Attached one waggon"
  end

  def detach_waggon
    if @waggons.nil? || @waggons.empty?
      puts "The train has no waggons"
    else
      @waggons.delete_at(-1)
      puts "Detached 1 waggon"
    end
  end

  def waggons
    puts @waggons
  end
end