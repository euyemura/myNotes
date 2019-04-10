Can you reverse a string, maybe without using the reverse method..

```javascript
function reverse(str) {
  let finalArr = []
  stringArr = str.split('')
  while (stringArr.length > 0) {
    finalArr.push(stringArr.pop())
  }
  return finalArr.join('')
}
```

```ruby
def reverse (str)
  if str.class != String || !str
    puts "Please enter a vald string"
    return
  elsif  str.length < 2
    return str
  end
  final_arr = []
  letters = str.chars
  final_arr << letters.pop while letters.length > 0
  final_arr.join('')
end
