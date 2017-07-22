class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = :cargo
  end

  def attach_waggon(waggon)
    super if waggon.class == CargoWaggon
  end
end
