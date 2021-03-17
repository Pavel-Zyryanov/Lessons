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
      puts "1. Создать станцию.\n2. Создать поезд.\n3. Создать маршрут.\n4. Изменить маршрут.\n5. Назначить маршрут поезду.\n6. Добавить вагон к поезду.\n7. Отцепить вагон от поезда."
      puts "8. Переместить поезд: вперед или назад.\n9. Посмотреть список станций и список поездов на станции.\n10. Занять место или объем в вагоне.\nВведите команду:"
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
      when 10
        take_place_in_car
      when 0
        break
      end
    end
  end

  private
  def all_stations_list_and_selection
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
    index = gets.to_i
    @stations[index - 1]
  end

  def all_routes_list_and_selection
    @routes.each.with_index(1) do |route, index|
      puts "#{index}. #{route.name}"
    end
    index = gets.to_i
    @routes[index - 1]
  end

  def all_trains_list_and_selection
    @trains.each.with_index(1) do |train, index|
      puts "#{index}.Номер поезда - #{train.number}, тип - #{train.type}."
    end
    index = gets.to_i
    @trains[index - 1]
  end

  def all_cars_list_and_selection
    @cars.reject { |car| car.train == nil }.each.with_index(1) do |car, index|
      puts "#{index}.id - #{car.id}, тип - #{car.type}."
    end
    index = gets.to_i
    @cars[index - 1]
  end

  def cars_list_and_select(train)
    train.cars.each.with_index(1) do |car, index|
      puts "#{index}. id вагона - #{car.id}, тип вагона - #{car.type}"
    end
    index = gets.to_i
    car = train.cars[index - 1]
  end

  def select_place(car)
    puts "Занять одно место в пассажирском вагоне / занять объем грузового вагона? \n Введите (0 для занятия пассажирского места или введите Объем вагона)"
    puts "Доступный объем вагона: #{car.free_volume}" if car.type == 'Cargo'
    puts "Доступное количество мест: #{car.free_seats}" if car.type == 'Passenger'
    choice = gets.to_i
    if (choice == 0) && (car.type == 'Passenger')
      if car.free_seats > 0
        car.take_seat
        puts "Было занято одно место, осталось #{car.free_seats}"
      else
        puts "Свободных мест в вагоне нет."
      end
    else
      volume = choice
      if (car.free_volume - volume) > 0
        car.load_volume(volume)
        puts "Был занят объем - #{volume}, осталось - #{car.free_volume}"
      else
        puts "Объем больше допустимого (суммарного) объема вагона."
      end
    end
  end

  def create_station
    attempts = 0
    begin
      puts "Введите название станции:\n"
      station_name = gets.strip.capitalize
      @stations << Station.new(station_name)
    rescue RuntimeError => error
      puts "Ошибка: #{error.message}"
      attempts += 1
    retry if attempts < 3
    end
    puts "Создана новая станция - #{station_name}"
  end

  def create_train
    attempts = 0
    begin
      puts "Ведите тип поезда:\n1. Пассажирский (Passenger).\n2. Грузовой (Cargo)."
      type = gets.to_i
      puts "Введите номер поезда:"
      number = gets.chomp.to_s
      if type == 1
        train = PassengerTrain.new(number)
      else
        train = CargoTrain.new(number)
      end
    rescue RuntimeError => error
      puts "Ошибка: #{error.message}"
      attempts += 1
    retry if attempts < 3
    end
    @trains << train
    puts "Создан новый поезд. Номер - #{train.number}, тип - #{train.type}"
  end

  def create_route
    while @stations.size < 2 do
      puts "Создайте станции!"
      create_station
    end
    attempts = 0
    begin
      puts "Выберите начальную станцию:"
      first_station = all_stations_list_and_selection
      puts "Выберите конечную станцию:"
      last_station = all_stations_list_and_selection
      route = Route.new(first_station, last_station)
    rescue RuntimeError => error
      puts "Ошибка: #{error.message}"
      attempts += 1
    retry if attempts < 3
    end
    @routes << route
    puts "Создан маршрут #{route.name}"
  end

  def change_route
    puts "Выберите маршрут для изменения:"
    route = all_routes_list_and_selection
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
      station = all_stations_list_and_selection
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
    train = all_trains_list_and_selection
    puts "Выберите маршрут:"
    route = all_routes_list_and_selection
    train.set_route(route)
  end

  def create_new_car
    attempts = 0
    begin
      puts "Введите id вагона: "
      id = gets.chomp.to_s
      puts "Введите тип вагона \n1.Пассажирский.\n2.Грузовой."
      type = gets.to_i
      if type == 1
        puts "Введите общее количество мест в вагоне:"
        number_seats = gets.to_i
        car = PassengerCar.new(id, number_seats)
      else
        puts "Введите общий объем вагона:"
        volume = gets.to_i
        car = CargoCar.new(id, volume)
      end
    rescue RuntimeError => error
      puts "Ошибка: #{error.message}"
      attempts += 1
      retry if attempts < 3
    @cars << car
    return car
    end
  end

  def add_car_to_train
    puts "Выберите поезд:"
    train = all_trains_list_and_selection
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
        car = all_cars_list_and_selection
        train.add_car(car)
      end
    end
  end

  def delete_car
    puts "Выберите поезд"
    train = all_trains_list_and_selection
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
    train = all_trains_list_and_selection
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
    puts "Показать информацию о:\n1.Станции\n2.Поезде"
    choice = gets.to_i
    case choice
    when 1
      puts "Список всех станций.\nВыберите станцию для просмотра дополнительной информации:"
      if @stations.empty?
        puts "Список станций пуст."
      else
        station = all_stations_list_and_selection
        if station.trains.empty?
          puts "На этой станции нет поездов."
        else
          station.each_trains {|train| puts "Номер поезда - #{train.number}, тип - #{train.type}, кол-во вагонов - #{train.cars.size}" }
        end
      end
    when 2
      puts "Список всех поездов.\nВыберите вагон для просмотра дополнительной информации:"
      train = all_trains_list_and_selection
      if train.cars.empty?
        puts "У этого поезда нет вагонов."
      else
        train.each_cars { |car| puts "ID вагона: #{car.id}, тип: #{car.type}, #{car.type == 'Passenger' ? "Свободных мест: #{car.free_seats}, Занятых мест: #{car.occupied_seats}" : "Свободный объем: #{car.free_volume}, Занятый объем: #{car.occupied_volume}"}" }
      end
    end
  end

  def take_place_in_car
    puts 'Выберите поезд:'
    train = all_trains_list_and_selection
    puts "Вы выбрали #{train.type} поезд. Выберите вагон, чтобы занять место / объем:"
    car = cars_list_and_select(train)
    select_place(car)
  end
end
