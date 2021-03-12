class Car
  attr_reader :id , :type
  attr_accessor :train
  include Manufacturer
  include Valid
  @@cars = {}

  CAR_ID_FORMAT = /[0-9]{2}-[0-9]{3}$/i

  def initialize(id)
    @id = id
    validate!
    @@cars[id] = self
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
