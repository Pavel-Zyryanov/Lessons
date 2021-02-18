class Train
  attr_accessor :speed, :number, :car_count, :route, :station
  attr_reader :type

  def initialize(number, type, car_count)
    @number = number
    @type = type
    @car_count = car_count
    @speed = 0
    puts "Добавлен поезд № #{number}. Тип: #{type}. Количество вагонов: #{car_count}."
  end

  def speed_up(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def add_car
    if speed == 0
      self.car_count += 1
      puts "К поезду № #{number} прицепили вагон. Теперь количество вагонов: #{car_count}."
    else
      puts "Прицепка вагонов может осуществляться только если поезд не движется!"
    end
  end

  def delete_car
    if car_count == 0
      puts "Вагонов уже не осталось."
    elsif speed == 0
      self.car_count -= 1
      puts "От поезда № #{number} отцепили вагон. Теперь количество вагонов: #{car_count}."
    else
      puts "Отцепка вагонов может осуществляться только если поезд не движется!"
    end
  end

  def set_route(route)
    self.route = route
    self.station = route.stations.first
    station.get_train(self)
    puts "Поезду № #{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def move_to_next_station
    station_index = route.stations.index(station)
    if (station_index + 1) != route.stations.size
      station = route.stations[station_index + 1]
    else
      puts "Вы находитесь на последней станции. Дальнейшее перемещение вперёд невозможно!"
    end
  end

  def move_to_previous_station
    station_index = route.stations.index(station)
    if station_index - 1 >= 0
      station = route.stations[station_index - 1]
    else
      puts "Вы находитесь на первой станции. Дальнейшее перемещение назад невозможно!"
    end
  end

  def go_forward
    self.station.depart_train(self)
    self.station = move_to_next_station
    self.station.get_train(self)
  end

  def go_back
    self.station.depart_train(self)
    self.station = move_to_previous_station
    self.station.get_train(self)
  end

end
