require_relative 'waggon'

class CargoWaggon < Waggon
  attr_reader :volume, :load_volume

  def initialize(volume)
    @volume = volume
  end

  def stow(load_volume)
    raise "Overweight, available space: #{volume}" if load_volume > volume
    @load_volume = load_volume
    @volume -= load_volume
  rescue => e
    puts e.message
    return
  end
end
