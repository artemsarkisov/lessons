arr = (0..100).to_a

fib = []

arr.each do |i|
  if i >= 2
    arr[i] = arr[i - 1] + arr[i - 2]
    break if arr[i] > 100
    fib.push(arr[i])
  else
    fib.push(arr[i])
  end
end

p fib

