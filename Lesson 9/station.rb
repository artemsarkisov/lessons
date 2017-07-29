require_relative 'validation'

class Station
  include Validation

  attr_reader :trains_list, :name

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /[a-z]/

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains_list = []
    @@stations << self
  end

  def get_train(train)
    @trains_list << train
  end

  def trains_by_number
    @trains_list.each do |train|
      puts "Train #{train.number}"
    end
  end

  def trains_by_type(type)
    selection = @trains_list.select { |train| train.type == type }
    puts "#{type.capitalize} trains: #{selection.length}"
  end

  def depart(train)
    @trains_list.delete(train)
  end

  def trains_to_block
    @trains_list.each { |train| yield(train) }
  end

  # private
  #
  # def validate!
  #   raise "Name can't be nil" if name.nil?
  #   raise 'Station should have at least two symbols' if @name.length < 2
  #   true
  # end

end

station = Station.new('foo')