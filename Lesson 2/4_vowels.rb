arr = ("a".."z").to_a
hash = {}
vowels = %w[a e i o u]

arr.each_with_index { |item, index|
  hash[item] = index + 1 if vowels.include?(item)
}

p hash