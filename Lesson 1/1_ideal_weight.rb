puts "What is your name?"
name = gets.chomp
puts "What is your height?"
height = gets.chomp

ideal_weight = (height.to_f - 110).round(1)

if ideal_weight > 0
  puts "#{name.capitalize}, your ideal weight would be #{ideal_weight}"
else
  puts "You have an appropriate weight!"
end