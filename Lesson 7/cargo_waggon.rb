require_relative 'waggon'

class CargoWaggon < Waggon

  attr_reader :volume,  :load_volume

  def initialize(volume)
    @volume = volume
  end

  def stow(load_volume)
    raise "Overweight, available space: #{self.volume}" if load_volume > self.volume
    @load_volume = load_volume
    @volume -= load_volume
  end
end

# waggon = CargoWaggon.new(150)
#
# puts waggon.volume
# puts waggon.load_volume
#
# waggon.stow(140)
#
# puts waggon.load_volume
# puts waggon.volume
#
# waggon.stow(11)
# puts waggon.volume

