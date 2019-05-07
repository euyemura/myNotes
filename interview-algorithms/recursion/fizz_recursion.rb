def fizz_buzz(number)
  if number % 15 == 0
    "#{number} is fizzbuzz"
  elsif number % 5 == 0
    "#{number} is fizz"
  elsif number % 3 == 0
    "#{number} is buzz"
  else
    number
  end
end

def fizz_iterate(number)
  for num in 1..number do
    p fizz_buzz(num)
  end
end

def fizz_recursion(number)
  return if number == 0
  p "the number is now #{number}"
  fizz_recursion(number -1)
  p fizz_buzz(number)
end
