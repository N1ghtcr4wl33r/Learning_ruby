puts "Введите первый коэффициент!"
a = gets.chomp.to_f

puts "Введите второй коэффициент!"
b = gets.chomp.to_f

puts "Введите третий коэффициент!"
c = gets.chomp.to_f

def d(a, b, c)
discr = b ** 2 - 4 * a * c
  if discr < 0
    return "Дискриминант равен #{discr}. Корней нет."
  elsif discr > 0
    return "Дискриминант равен #{discr}. Корни #{(-b + Math.sqrt(discr))/(2 * a)} и #{(-b - Math.sqrt(discr))/(2 * a)}!"
  else
    return"Дискриминант равен #{discr}. Корень равен #{-b/(2 * a)}!"
  end
end

puts d(a, b, c)
