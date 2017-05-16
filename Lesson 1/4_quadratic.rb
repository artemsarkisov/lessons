p "insert first quotient"

a = gets.to_f

p "insert second quotient"

b = gets.to_f

p "insert third quotient"

c = gets.to_f

discriminant = b**2 - 4 * a * c

if discriminant > 0
  x1 = ((- b + Math.sqrt(discriminant)) / (2 * a)).to_f.round(2)
  x2 = ((- b - Math.sqrt(discriminant)) / (2 * a)).to_f.round(2)
  p "x1 = #{x1}, x2 = #{x2}"
elsif discriminant == 0
  x = (- b / (2 * a)).to_f
  p "x1 = x2 = #{x}"
elsif discriminant < 0
  p "No roots"
end
