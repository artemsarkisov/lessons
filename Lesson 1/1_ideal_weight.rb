puts "What is your name?"
name = gets.chomp
puts "What is your height?"
height = gets.to_f.round(1)

ideal_weight = (height - 110)

if ideal_weight > 0
  puts "#{name.capitalize}, your ideal weight would be #{ideal_weight}"
else
  puts "You have an appropriate weight!"
end