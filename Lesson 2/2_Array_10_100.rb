# Заполнить массив числами от 10 до 100 с шагом 5
step = 5
start = 10
array_1 = []
while start <= 100 do
  array_1.push(start)
  start += step
end
puts "Array_1 =  #{array_1.inspect}"

# альтернативное решение с помощью range, step и разворотом в массив
array_2 = (10..100).step(5).to_a
puts "Array_2 =  #{array_2.inspect}"

# Проверка двух решений
if array_1 == array_2
  puts ("Массивы равны: Array_1 == Array_2")
end
