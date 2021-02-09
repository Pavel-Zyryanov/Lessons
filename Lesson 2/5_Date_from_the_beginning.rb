# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года

month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
date_summary = 0

# Ввод даты, преобразование введеной строки
puts "Введите день, месяц, год в формате дд.мм.гггг"
date = gets.gsub(".", " ").chomp.split.map{ |i| i.to_i }

# Проверка года на високосность
if ((date[2] % 4 == 0 && date[2] % 100 != 0) || date[2] % 400 == 0)
  month[1] = 29
end

# Вычисление даты от начала года
for i in 0..(date[1] - 2)
  date_summary += month[i]
end
date_summary += date[0]

# Вывод
puts "#{date[0]}.#{date[1]}.#{date[2]} - #{date_summary} день в году."
