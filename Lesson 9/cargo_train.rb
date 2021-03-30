# frozen_string_literal: true

class CargoTrain < Train
  validate :number, :type, String
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super
    @type = 'Cargo'
  end
end
