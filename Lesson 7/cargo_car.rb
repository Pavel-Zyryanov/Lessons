class CargoCar < Car
  attr_reader :free_volume

  def initialize(id, volume)
    super(id)
    @type = 'Cargo'
    @volume = volume
    @free_volume = volume
  end

  def take_place(volume)
    @free_volume -= volume if (@free_volume - volume) >= 0
  end

  def occupied_volume
    @volume - @free_volume
  end

  def free_volume
    @free_volume
  end
end
