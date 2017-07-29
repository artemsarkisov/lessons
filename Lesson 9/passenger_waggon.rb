require_relative 'waggon'

class PassengerWaggon < Waggon
  attr_reader :seats, :occupied_seats

  def initialize(seats)
    @seats          = seats
    @occupied_seats = 0
  end

  def take_seat
    raise 'All seats are taken.' if seats.zero?
    @occupied_seats += 1
    @seats          -= 1
  end
end
