class Route
  attr_reader :stations_list

  def initialize(first_st, last_st)
    @stations_list = [first_st.name, last_st.name]
  end

  def add_station(interim_st)
    @stations_list.insert(-2, interim_st.name)
  end

  def remove_station(interim_st)
    @stations_list.delete(interim_st)
  end
end