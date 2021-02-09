# Заполнить массив числами Фибоначчи до 100
# Задаем начальный массив с числами Фибоначчи,  предел значения числа Фибоначчи
array_fibonacci = [0, 1]
limit = 100

# Формирование массива с числами Фибоначчи в соотвтетствии с заданным пределом
while (array_fibonacci [-2] + array_fibonacci [-1]) <= limit
  array_fibonacci.push(array_fibonacci [-2] + array_fibonacci [-1])
end

#Вывод массива с числами Фибоначчи
puts array_fibonacci.inspect
