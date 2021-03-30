# frozen_string_literal: true

class CargoCar < Car
  validate :id, :presence
  validate :id, :format, CAR_ID_FORMAT
  validate :id, :type, String

  def initialize(id, place)
    super(id, place)
    @type = 'Cargo'
  end
end
