puts "Приветствую! Введите Ваше имя:"
name = gets.chomp

puts "Введите Ваш рост в сантиметрах:"
height = gets.chomp.to_f

perfect_weight = ( height - 110 ) * 1.15
if perfect_weight > 0
  puts "#{name}, Ваш идеальный вес составляет #{perfect_weight} килограмм."
  else puts "Ваш вес уже оптимальный"
end
