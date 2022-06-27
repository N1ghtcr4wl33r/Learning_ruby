puts "Введите число"
day = gets.chomp.to_i
puts "Введите номер месяца"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

february = 28
sum = "Этот год не високосный!"

if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
  february = 29
  sum = "Этот год високосный!"
end

arr = [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days = day
(1...month).each {|x| days += arr[x]}
puts "Порядковый номер даты равен #{days}.#{sum}"