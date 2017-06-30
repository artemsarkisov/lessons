require_relative 'validation'

class Station

  include Validation

  attr_reader :trains_list, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name        = name
    @trains_list = []
    @@stations << self
    validate!
  end

  def validate!
    raise "Name can't be nil" if name.nil? #нужно ли проверять на nil при обязательном параметре в конструкторе?
    raise "Station should have at least two symbols" if @name.length < 2
    true
  end

  def get_train(train)
    @trains_list << train
  end

  def trains_by_number
    @trains_list.each do |train|
      puts "Train ##{train.number}"
    end
  end

  def trains_by_type(type)
    selection = @trains_list.select { |train| train.type == type }
    puts "#{type.capitalize} trains: #{selection.length}"
  end

  def depart(train)
    @trains_list.delete(train)
  end
end