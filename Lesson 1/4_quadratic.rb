p "insert first quotient"

a = gets.to_i

p "insert second quotient"

b = gets.to_f

p "insert third quotient"

c = gets.to_f

discriminant = b**2 - 4*a*c

x1 = ((- b + Math.sqrt(discriminant))/(2*a)).to_f.round(2)

x2 = ((- b - Math.sqrt(discriminant))/(2*a)).to_f.round(2)


if discriminant > 0
  p "x1 = #{x1}, x2 = #{x2}"
elsif discriminant == 0
  p "x1 = x2 = #{x1}"
elsif discriminant < 0
  p "No roots"
end
