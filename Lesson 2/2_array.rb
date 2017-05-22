arr = []

(10..100).each { |i| arr << i if i % 5 == 0 }
p arr
