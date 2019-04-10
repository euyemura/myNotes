# O(n ^ 2)

What if you were asked to log all pairs of an array??

```javascript
const boxes = [1,2,3,4,5]

function logAllPairs(boxes) {
  finalArr = []
  for(let i = 0; i < boxes.length; i++) {
    for(let k = i + 1; k < boxes.length; k++) {
      finalArr.push([boxes[i], boxes[k]])
    }
  }
  return finalArr
}
function logAllAllPairs(boxes) {
  finalArr = []
  for(let i = 0; i < boxes.length; i++) {
    for(let k = 0; k < boxes.length; k++) {
      finalArr.push([boxes[i], boxes[k]])
    }
  }
  return finalArr
}
```

-----------------------------------------

```ruby
boxes = [1,2,3,4,5]
def get_all_pairs(array)
  final_arr = []
  array.each do |element|
    array.each do |other_el|
      final_arr << [element, other_el]
    end
  end
  final_arr
end

get_all_pairs(boxes)
```
Well, what is the big O of this?  It's not O(2n), it's actually, O(n^2) --> Quadratic time.

If you have 2 elements, then you'll have 4 operations, 1,1, 1,2, 2,1 ,2,2

With 3 elements, you'll have 9.

1,1 1,2 1,3 2,1 2,2 2,3 3,1 3,2 3,3

O(n^2) is horrible. 
