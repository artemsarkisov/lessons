puts "Please enter the day"
day = gets.chomp.to_i

puts "Please enter the month"
month = gets.chomp.to_i

puts "Please enter the year"
year = gets.chomp.to_i

months   = [31, 28, 31, 31, 30, 31, 30, 31, 30, 31, 30, 31]

if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
  months[1] = 29
end

if month == 1
  p day
else
  date = months[0..(month - 2)].inject(:+) + day
  p date
end