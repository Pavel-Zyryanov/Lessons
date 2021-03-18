class PassengerCar < Car

  def initialize(id, place)
    super(id, place)
    @type = 'Passenger'
  end

  def take_place
    super(1)
  end
end
