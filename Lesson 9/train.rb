# frozen_string_literal: true

class Train
  attr_accessor :speed, :route, :current_station
  attr_reader :type, :number, :cars

  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors
  attr_accessors_with_history :first
  strong_attr_accessor(:string_one, String)
  @@trains = {}

  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    validate!
    validate_train_exist
    @cars = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def each_cars(&block)
    @cars.each(&block)
  end

  def speed_up(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    if speed.zero? && @type == car.type
      @cars << car
      car.train = self
    else
      puts 'Прицепка вагонов может осуществляться только если поезд не движется!'
    end
  end

  def delete_car(car)
    if speed.zero?
      car.train = nil
      @cars.delete(car)
    else
      puts 'Отцепка вагонов может осуществляться только если поезд не движется!'
    end
  end

  def take_route(route)
    self.route = route
    self.current_station = route.stations.first
    current_station.get_train(self)
    puts "Поезду № #{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def go_forward
    if next_station
      current_station.depart_train(self)
      self.current_station = next_station
      current_station.get_train(self)
    else
      puts 'Вы находитесь на последней станции. Дальнейшее перемещение вперёд невозможно!'
    end
  end

  def go_back
    if previous_station
      current_station.depart_train(self)
      self.current_station = previous_station
      current_station.get_train(self)
    else
      puts 'Вы находитесь на первой станции. Дальнейшее перемещение назад невозможно!'
    end
  end

  private

  def current_station_index
    route.stations.index(current_station)
  end

  def next_station
    route.stations[current_station_index + 1] if (current_station_index + 1) != route.stations.size
  end

  def previous_station
    route.stations[current_station_index - 1] if current_station_index - 1 >= 0
  end

  protected

  def validate_train_exist
    raise 'Поезд с таким номером уже существует' unless @@trains[number].nil?
  end
end
