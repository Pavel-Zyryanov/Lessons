class PassengerCar < Car

  def initialize(id, place)
    super(id, place)
    @type = 'Passenger'
  end

  def take_place
    @occupied_place += 1 if @place - @occupied_place > 0
  end
end
