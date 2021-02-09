#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
hash_vowels = {}
alphabet = ('a'..'z').to_a
vowels = ['a' ,'e' ,'i' ,'o' ,'u' ,'y']

#Просмотр массива алфавита с индексами элементов, занесение в hash значения индексов гласных букв
alphabet.each_with_index do |letter, index|
   if vowels.include?(letter)
     hash_vowels[letter] = index + 1
   end
end

#Вывод hash_vowels
hash_vowels.each do |key, value|
  puts "#{key} - #{value}"
end
