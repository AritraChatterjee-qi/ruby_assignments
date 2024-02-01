# This fuction takes an integer array as an argument and returns the sum of all the element.
def array_sum(arr)
  unless arr.kind_of?(Array)
    return "ERROR! Function input must be an array"
  end

  sum = 0

  arr.each do |ele|
     sum += ele
  end

  sum
end

arr = [1,2,3,4,5,6,7,8,9,10]
result = array_sum(arr)
puts "Sum of input #{arr} is #{result}"