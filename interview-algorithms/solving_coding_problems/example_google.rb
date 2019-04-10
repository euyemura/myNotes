list = [1,2,3,9]

def find_pair (array, target_sum)
  array.each_with_index do |num, index|
    array.each_with_index do |other_num, other_index|
      if other_index > index
        puts "checking #{num} and #{other_num}"
        return [num, other_num] if (num + other_num == target_sum)
      end
    end
  end
  "There are no pairs that add up to #{target_sum}"
end

def find_pair_equal_sum(array, target_sum)
  left_pointer = 0
  right_pointer = array.length - 1
  while left_pointer < right_pointer
    sum = array[left_pointer] + array[right_pointer]
    if sum == target_sum
      return [array[left_pointer],  array[right_pointer]]
    elsif sum > target_sum
      right_pointer -= 1
    else
      left_pointer += 1
    end
  end
  "there is no match"
end

find_pair_equal_sum(list, 8)
