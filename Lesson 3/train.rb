class Train
  attr_accessor  :speed, :route, :current_station, :car_count
  attr_reader :type, :number

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
    self.current_station = route.stations.first
    self.current_station.get_train(self)
    puts "Поезду № #{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}"
  end

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
end
