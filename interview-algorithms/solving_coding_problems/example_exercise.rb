# given two arrays, create a function that lets a user know (true, false) whether these two arrays contain any common items.

array1 = ['a', 'b', 'c', 'x']
array2 = ['z', 'y', 'i']
# should return false.

array3 = ['a', 'b', 'c', 'x']
array4 = ['z', 'y', 'x']

def find_common_elements(array1, array2)
  if array1.size <= array2.size
    array1.each do |element|
      return true if array2.include? element
    end
  else
    array2.each do |element|
      return true if array1.include? element
    end
  end
  return false
end

# should probably ask how big these arrays would get.  If its always small, then the double for loop or quadratic would be ok.

# If they can get really big, then just make it as efficient as possible. So, the double for loop...

# how can we make it more efficient? Maybe use a hash table!



#----------------------------------------

# array1 ==> hash {
#  'a' => true,
#  'b' => true,
#  'c' => true,
# }

array1 = ['a', 'b', 'c', 'x']
array2 = ['z', 'y', 'i', 'a']
# should return false.

array3 = ['a', 'b', 'c', 'x']
array4 = ['z', 'y', 'x']

def find_common_elements2(arr1, arr2)
  # first loop through first and create a hash where each key is the item in the array with values of true.
  # loop through second array and check if item in second array exists as a key of created object.
  # this is two loops, but not nested... so It could be O(a + b)
  hash_keys = arr1.product([true]).to_h
  arr2.each do |el|
    return true if hash_keys.has_key? el
  end
  return false
end

def find_common_elements3(array1, array2)
    array1.any? {|el| array2.include? el}
end

p find_common_elements3(array1, array2)
p find_common_elements3(array3, array4)
