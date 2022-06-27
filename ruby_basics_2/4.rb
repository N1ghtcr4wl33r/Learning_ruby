arr = ("a".."z").to_a
hash = {}
arr.each do |x|
  new_arr = ["a", "e", "i", "o", "u", "y"]
  if new_arr.include?(x)
  hash[x] = arr.index(x) + 1
  end
end

puts hash