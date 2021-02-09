# Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
basket_product = {}
input_stream = []
summary = 0
puts "Через пробел введите название товара, цену за единицу, количество купленного товара."
puts "Каждый следующий товар необходимо вводить с новой строки,"
puts "Для выхода из режима заполнения списка товаров введите команду 'стоп'."

# Цикл ввода данных
loop do
  input_stream << gets.chomp
  break if input_stream.include?("стоп")
end

# Формирование хеша: Product : {:price => value, :count => value, :sum => price * count}
# Нахождение итоговой суммы покупок.
for i in 0..input_stream.size - 2
  product = input_stream[i].split
  price = product[1].to_f
  count = product[2].to_f
  basket_product[product[0]] = {
    price: price,
    count: count,
    sum: price * count
  }
  summary += basket_product[product[0]][:sum]
end

# Вывод хеша и итоговой суммы покупок
basket_product.each do |key, value|
  puts "#{key} : #{value}"
end
puts "Итоговая сумма покупок: #{summary}"
