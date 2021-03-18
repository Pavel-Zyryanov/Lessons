class CargoCar < Car

  def initialize(id, place)
    super(id, place)
    @type = 'Cargo'
  end

  def take_place(place)
    @occupied_place += place if (@place - @occupied_place - place) >= 0
  end
end
