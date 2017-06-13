class Station

  attr_reader :trains_list, :name

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

  def trains_by_type

    passenger = @trains_list.select { |train| train.type == :passenger }
    cargo     = @trains_list.select { |train| train.type == :cargo }
    puts "#{passenger.length} passenger train(s), and #{cargo.length} cargo train(s) on the station"
  end

  def depart(train)
    @trains_list.delete(train)
  end
end