# frozen_string_literal: true

class CargoCar < Car
  def initialize(id, place)
    super(id, place)
    @type = 'Cargo'
  end
end
