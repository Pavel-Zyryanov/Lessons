class Train
  attr_accessor  :speed, :route, :current_station
  attr_reader :type, :number, :cars
  include Manufacturer
  include InstanceCounter
  include Valid
  @@trains = {}

  NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @cars = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
      @@trains[number]
  end

  def speed_up(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    if speed == 0 && @type == car.type
      @cars << car
      car.train = self
    else
      puts "Прицепка вагонов может осуществляться только если поезд не движется!"
    end
  end

  def delete_car(car)
    if speed == 0
      car.train = nil
      @cars.delete(car)
    else
      puts "Отцепка вагонов может осуществляться только если поезд не движется!"
    end
  end

  def set_route(route)
    self.route = route
    self.current_station = route.stations.first
    self.current_station.get_train(self)
    puts "Поезду № #{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def go_forward
    if next_station
      self.current_station.depart_train(self)
      self.current_station = next_station
      self.current_station.get_train(self)
    else
      puts "Вы находитесь на последней станции. Дальнейшее перемещение вперёд невозможно!"
    end
  end

  def go_back
    if previous_station
      self.current_station.depart_train(self)
      self.current_station = previous_station
      self.current_station.get_train(self)
    else
      puts "Вы находитесь на первой станции. Дальнейшее перемещение назад невозможно!"
    end
  end

  private
  # В данном классе можно вынести в private данные методы: current_station_index, next_station, previous_station.
  #  Причина отнесения в private - отсутствие внешних вызовов.

  def current_station_index
    return route.stations.index(current_station)
  end

  def next_station
    if (current_station_index + 1) != route.stations.size
      next_station = route.stations[current_station_index + 1]
      return next_station
    end
  end

  def previous_station
    if current_station_index - 1 >= 0
      previous_station = route.stations[current_station_index - 1]
      return previous_station
    end
  end

  protected
  def validate!
    validate_train_number
    validate_train_exist
  end

  def validate_train_number
    raise 'Неверный формат номера поезда' if @number !~ NUMBER_FORMAT
  end

  def validate_train_exist
    raise 'Поезд с таким номером уже существует' unless @@trains[number].nil?
  end

end
