first_num = 1
second_num = 1
fibonacci = [0, 1, 1]
(1...10).each do |x|
first_num, second_num = second_num, first_num + second_num
fibonacci.push(second_num)
end
print fibonacci
