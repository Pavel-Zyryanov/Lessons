class Menu
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @cars = []
  end

  def start_menu
    loop do
      puts "\nУважаемый пользователь, для выбора действия нужно ввести цифру команды из списка и нажать клавишу Enter на клавиатуре.\nДля выхода из программы введите 0.\n\nСписок команд:\n"
      puts "1. Создать станцию.\n2. Создать поезд.\n3. Создать маршрут.\n4. Изменить маршрут.\n5. Назначить маршрут поезду."
      puts "6. Добавить вагон к поезду.\n7. Отцепить вагон от поезда.\n8. Переместить поезд: вперед или назад.\n9. Посмотреть список станций и список поездов на станции.\nВведите команду:"
      choice = gets.to_i
      case choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        change_route
      when 5
        set_route_to_train
      when 6
        add_car_to_train
      when 7
        delete_car
      when 8
        move_train
      when 9
        info_stations_trains
      when 0
        break
      end
    end
  end

  private
  def all_stations_list
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
  end

  def all_routes_list
    @routes.each.with_index(1) do |route, index|
      puts "#{index}. #{route.name}"
    end
  end

  def all_trains_list
    @trains.each.with_index(1) do |train, index|
      puts "#{index}.Номер поезда - #{train.number}, тип - #{train.type}."
    end
  end

  def all_cars_list
    @cars.reject { |car| car.train == nil }.each.with_index(1) do |car, index|
      puts "#{index}.id - #{car.id}, тип - #{car.type}."
    end
  end

  def select_train(index)
    train = @trains[index - 1]
    return train
  end

  def select_station(index)
    station = @stations[index - 1]
    return station
  end

  def select_route(index)
    route = @routes[index - 1]
    return route
  end

  def select_car(index)
    car = @cars[index - 1]
    return car
  end

  def create_station
    puts "Введите название станции:\n"
    station_name = gets.strip.capitalize
    if @stations.map { |station| station.name }.include?(station_name)
      puts "Такая станция уже есть."
    else
      @stations << Station.new(station_name)
    end
  end

  def create_train
    puts "Ведите тип поезда:\n1. Пассажирский (Passenger).\n2. Грузовой (Cargo)."
    type = gets.to_i
    puts "Введите номер поезда:"
    number = gets.to_i
    if type == 1
      train = PassengerTrain.new(number)
    else
      train = CargoTrain.new(number)
    end
    @trains << train
  end

  def create_route
    while @stations.size < 2 do
      puts "Создайте станции!"
      create_station
    end
    puts "Выберите начальную станцию:"
    all_stations_list
    index = gets.to_i
    first_station = select_station(index)
    puts "Выберите конечную станцию:"
    all_stations_list
    index = gets.to_i
    last_station = select_station(index)
    route = Route.new(first_station, last_station)
    @routes << route
  end

  def change_route
    puts "Выберите маршрут для изменения:"
    all_routes_list
    index = gets.to_i
    route = select_route(index)
    puts "1.Удалить станцию\n2.Добавить станцию"
    choice = gets.to_i
    case choice
    when 1
      puts "Вы не можете удалить станцию,т.к. в маршруте всего 2 станции" if route.stations.length == 2
      puts "Какую станцию удалить?"
      route.show_all_station
      index = gets.to_i
      station = route.stations[index - 1]
      route.delete_station(station)
    when 2
      puts "Какую станцию добавить в маршрут?"
      all_stations_list
      index = gets.to_i
      station = select_station(index)
      route.add_station(station)
    end
  end

  def set_route_to_train
    if @trains.empty?
      puts "Нет ни одного поезда, создайте поезд!"
      create_train
    end
    if @routes.empty?
      puts "Нет ни одного маршрута, создайте маршрут!"
      create_route
    end
    puts "Выберите поезд:"
    all_trains_list
    index = gets.to_i
    train = select_train(index)
    puts "Выберите маршрут:"
    all_routes_list
    index = gets.to_i
    route = select_route(index)
    train.set_route(route)
  end

  def create_new_car
    puts "Введите id вагона: "
    id = gets.to_i
    puts "Введите тип вагона \n1.Пассажирский.\n2.Грузовой."
    type = gets.to_i
    if type == 1
      car = PassengerCar.new(id)
    else
      car = CargoCar.new(id)
    end
    @cars << car
    return car
  end

  def add_car_to_train
    puts "Выберите поезд:"
    all_trains_list
    index = gets.to_i
    train = select_train(index)
    puts "Создать вагон или выбрать из существующих?\n1.Создать новый\n2.Выбрать из существующих"
    index = gets.to_i
    case index
    when 1
      car = create_new_car
      train.add_car(car)
    when 2
      if @cars.empty?
        puts "Нет ни одного вагона"
      else
        puts "Выберите нужный вагон"
        all_cars_list
        index = gets.to_i
        car = select_car(index)
        train.add_car(car)
      end
    end
  end

  def delete_car
    puts "Выберите поезд"
    all_trains_list
    index = gets.to_i
    train = select_train(index)
    if @cars.empty? && train.cars == nil
      puts "Нет прицепленных вагонов."
    else
      puts "Вагоны, прицепленные к данному поезду, выберите какой нужно отцепить"
      train.cars.each.with_index(1) do |car, index|
      puts "#{index}.id - #{car.id}, тип - #{car.type}."
    end
    index = gets.to_i
    car = train.cars[index - 1]
    train.delete_car(car)
    end
  end

  def move_train
    puts "Выберите поезд:"
    all_trains_list
    index = gets.to_i
    train = select_train(index)
    puts "Выберите направление:\n1.Вперед\n2.Назад"
    direction = gets.to_i
    if direction == 1
      train.go_forward
    elsif direction == 2
      train.go_back
    else
      puts "Нет такого направления"
    end
  end

  def info_stations_trains
    puts "Список всех станций.\nВыберите станцию для просмотра дополнительной информации:"
    if @stations.empty?
      puts "Список станций пуст."
    else
      all_stations_list
      index = gets.to_i
      station = select_station(index)
      if station.trains.empty?
        puts "На этой станции нет поездов."
      else
        station.trains.each do |train|
          puts "Номер поезда - #{train.number}, тип - #{train.type}"
          end
      end
    end
  end
end
