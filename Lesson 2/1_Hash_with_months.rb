# Создание хеша (месяц - количество дней)
months = {
  'January'   => 31,
  'February'  => [28, 29],
  'March'     => 31,
  'April'     => 30,
  'May'       => 31,
  'June'      => 30,
  'July'      => 31,
  'August'    => 31,
  'September' => 30,
  'October'   => 31,
  'November'  => 30,
  'December'  => 31
}

# Вывод месяцев с количеством дней == 30
months.each do |month, days|
  puts month if days == 30
end
