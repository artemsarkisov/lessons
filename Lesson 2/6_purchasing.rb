hash = {}

loop do
  p "Enter the product name"
  product_name = gets.chomp
  break if product_name == "stop"

  p "Enter the price of the product"
  product_price = gets.chomp.to_f

  p "Enter the amount of the product"
  product_amount = gets.chomp.to_f

  hash[product_name] = { product_price => product_amount }
end

total = []

hash.each do |product_name, price_amount|
  price_amount.each do |price, amount|
    sum = price * amount
    total.push(sum)
    p "#{product_name}: price: #{price}, amount: #{amount}, paid: #{sum}"
  end
end

p "total amount paid: #{total.inject(:+)}"
