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

  def trains_by_type(type)
    selection = @trains_list.select { |train| train.type == type }
    puts "#{type.capitalize} trains: #{selection.length}"
  end

  def depart(train)
    @trains_list.delete(train)
  end
end