# Идеальный вес
# Запрос у пользователя имени и роста
puts "Введите ваше имя:"
name = gets.chomp
puts "Введите ваш рост в сантиметрах:"
growth = gets.chomp.to_i

#  Вычисляем идеальный вес
weight= (growth-110)*1.15

#Вывод, согласно условию задачи
if weight<0
    puts "#{name}, ваш вес уже оптимальный!"
else  puts "#{name}, ваш идеальный вес: #{weight.round(2)} кг."
end
