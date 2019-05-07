def reverse_string(str)
  reversed_array = []
  counter = str.length - 1
  while (counter >= 0)
    reversed_array << str[counter]
    counter -= 1
  end
  reversed_array.join
end

def reverse_string(str)
  reversed_array = []
  for index in 0...str.length do
    reversed_array.unshift(str[index])
  end
  reversed_array.join
end

def reverse_string_recursively(str)
  if !str.empty?
    puts str
    return str.slice!(-1) +  reverse_string_recursively(str)
  else
    return ""
  end
end

reverse_string("Hello World!")
