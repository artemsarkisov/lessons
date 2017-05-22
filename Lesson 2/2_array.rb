arr = []

(10..100).each { |i| arr.push(i) if i % 5 == 0 }
p arr
