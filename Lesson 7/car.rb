class Car
  attr_reader :id , :type, :place, :occupied_place
  attr_accessor :train
  include Manufacturer
  include Valid
  @@cars = {}

  CAR_ID_FORMAT = /[0-9]{2}-[0-9]{3}$/i

  def initialize(id, place)
    @id = id
    validate!
    @place = place
    @occupied_place = 0
    @@cars[id] = self
  end

  def free_place
    @place - @occupied_place
  end

  def take_place(place)
    @occupied_place += place if free_place >= place
  end

  protected

    def validate!
      validate_car_id
      validate_car_exist
    end

    def validate_car_id
      raise 'Неверный формат ID вагона' if @id !~ CAR_ID_FORMAT
    end

    def validate_car_exist
      raise 'Вагон с таким ID уже есть' unless @@cars[id].nil?
    end
end
