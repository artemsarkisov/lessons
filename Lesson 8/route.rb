require_relative 'validation'

class Route
  include Validation
  attr_reader :stations_list
  def initialize(first_st, last_st)
    @stations_list = [first_st, last_st]
    validate!
  end

  def add_station(interim_st)
    raise 'The station is already in use' if @stations_list.include?(interim_st)
    @stations_list.insert(-2, interim_st)
  end

  def remove_station(interim_st)
    raise 'Route can\'t be less than two stations' if @stations_list.length < 3
    @stations_list.delete(interim_st)
  end

  private

  def validate!
    unless stations_list.all? { |station| station.is_a?(Station) }
      raise 'Route should be created from available stations'
    end
    true
  end
end
