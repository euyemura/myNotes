def two_sum(nums, target)
    numbers_hash = {}
    nums.each.with_index do |num, index|
        if numbers_hash.has_key? (num)
            return [numbers_hash[num], index]
        else
            numbers_hash[target - num] = index
        end
    end
    puts "there are no pairs equal to #{target}"
end


def two_sum(nums, target)
    sorted_nums = nums.sort
    left = 0
    right = sorted_nums.length - 1
    while left < right
        sum = sorted_nums[left] + sorted_nums[right]
        if sum == target
            return [left, right]
        elsif sum > target
            right -= 1
        else
            left += 1
        end
    end
    puts "there are no pairs equal to #{target}"
end

# Input: [-2,1,-3,4,-1,2,1,-5,4],
# Output: 6
# Explanation: [4,-1,2,1] has the largest sum = 6.

def max_sub_array(nums)
  contig_array = []

end
