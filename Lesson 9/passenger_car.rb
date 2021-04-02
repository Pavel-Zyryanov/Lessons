# frozen_string_literal: true

class PassengerCar < Car
  validate :id, :presence
  validate :id, :format, CAR_ID_FORMAT

  def initialize(id, place)
    super(id, place)
    @type = 'Passenger'
  end

  def take_place
    super(1)
  end
end
