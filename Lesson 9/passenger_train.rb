# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :type, String
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super
    @type = 'Passenger'
  end
end
