puts "Введите первую сторону треугольника"
a = gets.chomp.to_f

puts "Введите вторую сторону треугольника"
b = gets.chomp.to_f

puts "Введите третью сторону треугольника"
c = gets.chomp.to_f

case triangle(a, b, c)
  when ( a > b && a > c ) && ( a ** 2  == b ** 2 + c ** 2 )
    puts "Этот треугольник прямоугольный!"
  when ( b > a && b > c ) && ( b ** 2 == a ** 2 + c ** 2 )
    puts "Этот треугольник прямоугольный!"
  when ( c > a && c > b ) && ( c ** 2 == a ** 2 + b ** 2 )
    puts "Этот треугольник прямоугольный!"
  when ( a == b && b == c ) && a == c
    puts "Этот треугольник равносторонний!"
  when ( a == b || b == c ) || a == c
    puts "Этот треугольник равнобедренный!"
  else
    puts "Данные введены неправильно!"
      end
end

puts triangle(a, b, c)
