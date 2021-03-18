class PassengerCar < Car
  attr_reader :number_free_seats

  def initialize(id, number_seats)
    super(id)
    @type = 'Passenger'
    @number_seats = number_seats
    @number_free_seats = number_seats
  end

  def take_place
    @number_free_seats -= 1 if @number_free_seats > 0
  end

  def occupied_seats
    @number_seats - @number_free_seats
  end

  def free_seats
    @number_free_seats
  end
end
