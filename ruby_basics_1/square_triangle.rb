puts "Эта программа вычисляет площадь треугольника. Введите длину основания:"
a = gets.chomp.to_f

puts "Введите длину высоты:"
h = gets.chomp.to_f

square = 0.5 * a * h
puts "Площадь треугольника равна #{square}."
