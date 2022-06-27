list = Hash.new

loop do
  puts "Введите название товара (введите 'стоп', чтобы завершить ввод):"
  goods = gets.chomp.to_s
  break if goods == "стоп"
  puts "Введите цену за единицу товара:"
  price  = gets.chomp.to_f
  puts "Введите количество купленного товара:"
  amount = gets.chomp.to_f
  list[goods.to_s] = { price: price, amount: amount}
end

total_sum = 0

list.each do |key, value|
  prices = value[:amount] * value[:price]
  total_sum += prices
  puts " Итоговая сумма товара #{key} составляет #{prices} "
end

puts " Итоговая сумма всех покупок в корзине: #{total_sum} "
