require_relative 'module'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include InstanceCounter
  include CompanyName
  include Validation

  TRAIN_NUMBER = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

  attr_reader :current_speed, :current_station, :previous_station,
              :next_station, :route, :number, :waggons

  validate :number, :presence
  validate :number, :type, Integer
  validate :number, :format, TRAIN_NUMBER

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, options = {})
    @number = number
    validate!
    @waggons         = []
    @current_speed   = options[:current_speed] || 0
    @@trains[number] = self
    register_instance
  end

  def speed_up=(speed)
    @current_speed += speed
  end

  def brake
    @current_speed = 0
  end

  def route=(route)
    @route            = route
    @current_station  = @route.stations_list.first
    @next_station     = @route.stations_list[1]
    @previous_station = nil
  end

  def move_to_next_station
    raise 'Can\'t move, the train has no route!' if @current_station.nil?
    raise 'No next st' if @current_station == @route.stations_list.last
    station_index     = @route.stations_list.index(@current_station) + 1
    @next_station     = @route.stations_list[station_index + 1]
    @previous_station = @current_station
    @current_station  = @route.stations_list[station_index]
  end

  def move_to_previous_station
    raise 'Can\'t move, the train has no route!' if @current_station.nil?
    raise 'No previous st' if @current_station == @route.stations_list.first
    station_index    = @route.stations_list.index(@current_station) - 1
    @next_station    = @current_station
    @next_station    = @route.stations_list[station_index - 1]
    @current_station = @route.stations_list[station_index]
  end

  def attach_waggon(waggon)
    @waggons << waggon if @current_speed.zero?
  end

  def detach_waggon(waggon)
    @waggons.delete(waggon) if @current_speed.zero?
  end

  def waggons_to_block(block)
    raise 'The train has no waggons' if @waggons.empty?
    @waggons.each_with_index { |waggon, index| block.call(waggon, index) }
  end

  # private

  # def validate!
  #   raise 'Incorrect number format, try again.' unless number =~ TRAIN_NUMBER
  #   true
  # end
end


train = Train.new(12345)