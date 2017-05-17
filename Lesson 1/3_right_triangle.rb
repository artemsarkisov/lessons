p "Введите значения сторон треугольника:"

a = gets.to_f
b = gets.to_f
c = gets.to_f

val = [a, b, c].sort

right_triangle     = val[2]**2 == val[0]**2 + val[1]**2
isosceles_triangle = val.uniq.length == 2
equal_triangle     = val.uniq.length == 1

if right_triangle
  p "Это прямоугольный #{'равнобедренный ' if isosceles_triangle}треугольник."
elsif equal_triangle
  p "Это не прямоугольный, а равнобедренный равносторонний треугольник."
else
  p "Это не прямоугольный треугольник."
end