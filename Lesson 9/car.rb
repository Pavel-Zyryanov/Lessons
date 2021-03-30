# frozen_string_literal: true

class Car
  attr_reader :id, :type, :place, :occupied_place
  attr_accessor :train

  include Manufacturer
  include Validation
  @@cars = {}

  CAR_ID_FORMAT = /[0-9]{2}-[0-9]{3}$/i.freeze

  validate :id, :presence
  validate :id, :format, CAR_ID_FORMAT
  validate :id, :type, String

  def initialize(id, place)
    @id = id
    validate!
    validate_car_exist
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

  def validate_car_exist
    raise 'Вагон с таким ID уже есть' unless @@cars[id].nil?
  end
end
