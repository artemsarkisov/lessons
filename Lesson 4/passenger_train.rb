class PassengerTrain < Train

  attr_reader :type

  def initialize(number)
    super
    @type = :passenger
  end

  def attach_waggon(waggon)
    super if waggon.class == PassengerWaggon
  end
end