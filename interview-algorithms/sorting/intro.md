# Sorting

Why sort?  We have a sort function... Not really.  

Take an array of numbers and sort them, and write it for yourself.

Sorting isn't a big deal when you're talking about small inputs. How about when you have huge inputs?  Well, if you have huge inputs then you may want to use a different sorting algorithm.

There are a ton of sorting algorithms, so lets learn the the basics.

- Bubble sort
- Insertion sort
- Selection sort
- Merge sort
- Quick sort

```ruby
basket = [2, 65, 34, 2, 1, 7, 8]
basket.sort
# => [1, 2, 2, 7, 8, 34, 65]
# Do you know how Ruby sorts different data types?
words = %w{hello from the other side}
words.sort
# => ["from", "hello", "other", "side", "the"]
```
## Sorting Algorithms

You probably wont ever need to write a sorting algorithm from scratch, there are many libraries from that.

## Bubble Sort

Bubble, insertion, and selection sort are the more basic ways of sorting.

Merge and quick are more complex and can be more efficient.

[6,5,3,1,8,7,2,4]

You do this by looking at pairs and repeatedly looping through the items.  It is one of the most simple algorithms.

```ruby
def custom_bubble(array)
  array = array.dup
  while true
    current_arr = array.dup
    for index in 0...array.length do
      current = array[index]
      if array[index + 1] && array[index] > array[index + 1]
        array[index] = array[index + 1]
        array[index + 1] = current
      end
    end
    return array if array == current_arr
  end
end

def custom_bubble(array)
  array = array.dup
  for index in 0...array.length do
    for index in 0...array.length do
      current = array[index]
      if array[index + 1] && array[index] > array[index + 1]
        array[index] = array[index + 1]
        array[index + 1] = current
      end
    end
  end
  return array
end

arr = [1,6,3,67,8,3,2,5,7,4,25,452,2,72,641,17]

custom_bubble(array)
```

### Selection Sort

It finds the smalled item, and puts it as the first index.

```ruby
arr = [1,6,3,67,8,3,2,5,7,4,25,452,2,72,641,17]

def selection_sort(array)
  array = array.dup
  for outer_index in 0...array.length do
    current_min = array[outer_index]
    index_of_switch = outer_index
    for inner_index in outer_index...array.length do
      if array[inner_index] < current_min
        current_min = array[inner_index]
        index_of_switch = inner_index
      end
    end
    array[index_of_switch] = array[outer_index]
    array[outer_index] = current_min
  end
  return array
end
```

### Insertion Sort

There are cases where it is extremely fast.

It's useful for times when the list is almost sorted, or already sorted.

You can get O(n) when list is almost sorted.

```ruby
numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]

arr = [1, 6, 3, 67, 8, 3, 2, 5, 7, 4, 25, 452, 2, 72, 641, 17]

def insert_sort(array)
  array = array.dup
  array.each_with_index do |num, index|
    if (index != array.length-1) && num > array[index + 1]
      array[index] = array[index + 1]
      array[index+1] = num
      count = index
      # if we made a switch, then now we'll call a while loop to check the number that we switched with the numbers before it, it breaks the loop once the number is no longer smaller than any numbers before it.
      p array
      while (count > 0)
        p "is #{array[count]} less than #{array[count -1]}"
        if array[count] < array[count -1]
          tmp = array[count - 1]
          array[count - 1]  = array[count]
          array[count] = tmp
          count -= 1
          p array
        else
          break
        end
      end
    end
  end
  return array
end

insert_sort(arr)
insert_sort(numbers)
```

### Merge Sort

Merge sort and quick sort use divide and conquer. O(n log n)

No more nested for loops! This is better than O(n^2), but worse than linear time.

Sorting exercise
