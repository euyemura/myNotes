In the past two exercises, we calculated the Big O.  But it can be easier then going thru each step and adding up all the constant times and linear times to get something like O(3 + 5n)

The past two really just boiled down to O(n).

You generally will give a general O notation, like O(n), O(1), O(log n).

So here are the four rules for calculating the Big O.

1. Worst Case

For example, in the finding nemo example, we had an array of values, and we looped through the entire array even though we found nemo quite quickly... So we really should have stopped at finding nemo. We could have hit `break;` once we found Nemo. This significantly quickens the code.  However, for Big O we have to assume that Nemo would have been the last value.   So write the most efficient code, but assume it's the worst case scenario.

2. Remove Constants

O(n/2 + 101), there is some unnecessary information here.

O(n + 1), we're talking about how it scales, so really though, it would turn into. The adding of 1 or 101 becomes increasingly insignificant as it scales. And n/2 doesn't really matter because it's pretty much still scaling at the same rate, basically linearly.

O(n)

How about this...

```javascript

function compressBoxesTwice(boxes) {
  boxes.forEach(function(boxes) {
    console.log(boxes);
  })
  boxes.forEach(function(boxes) {
    console.log(boxes);
  })
}
```
--------------------------------------

```ruby
def compress_boxes_twices(boxes)
  boxes.each {|box| puts box}
  boxes.each {|box| puts box}
end
```

So, we have O(2n).  We again drop the constants, so O(n).  O(2n) is a steeper line than O(n), it's still a linear operation, it increases at a constant rate.

3. Different terms for inputs

```ruby
def compress_boxes_twices(boxes)
  boxes.each {|box| puts box}
  boxes.each {|box| puts box}
end
```

This is a classic O(n), which was originally O(2n)

But how about this...

```ruby
def compress_two_boxes(boxes1, boxes2)
  boxes1.each {|box| puts box}
  boxes2.each {|box| puts box}
end
```

Is this O(n)...? Both of these loops, these operations, do depend on the size of both these inputs, so this is not O(n) it is O(n + y)

But what about a nested for loop.  

So, if these were nested, you would multipy,

Instead of O(a + b), this happens when the loops are on same indentation, then you would have O(a*b)

4. Drop non dominants

```javascript
//here's an example

function printAllNumbersThenAllPairSums(numbers) {
  console.log('these are the numbers:');
  numbers.forEach(function(number) {
    console.log(number)
  });

  console.log('and these are their sums:');
  numbers.forEach(function(firstNumber) {
    numbers.forEach(function(secondNumber) {
      console.log(firstNumber + secondNumber)
    });
  });
}

printAllNumbersThenAllPairSums([1,2,3,4,5])
```

-------------------------------------------

```ruby
def print_all_nums_then_sum (array)
  puts "These are the numbers"
  array.each {|el| puts el}

  puts "These are all their sums:"
  array.each do |el|
    array.each do |other_el|
      puts "#{el} and #{other_el} add up to #{el + other_el}"
    end
  end
end

print_all_nums_then_sum([1,2,3,4,5])
```

I think for both of these it would be O(n + n^2)

Dropping the non dominant terms would mean dropping the least big O, so it would just equal
O(n^2)

If you had three nested layers, it would be
O(n^3), but this means you are probably do something badly.
