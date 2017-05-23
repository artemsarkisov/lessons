arr = [0] # or arr = []
i = 1

until i > 100
  arr << i
  i = arr.last(2).inject(:+)
end

p arr