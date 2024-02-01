# This fuction takes an integer array as an argument and returns the sum of all the element.
def arraySum(arr)
  is_array = arr.kind_of?(Array)
  
  if !is_array
    return "ERROR! Function input must be an array"
  end

  sum = 0;

  # using for loop to calculate the sum of all elements in the array
  #for i in 0...arr.length
  #  sum += arr[i];
  #end

  # fusing or in loop to calculate the sum of all elements in the array
  #for ele in arr
  #    sum += ele;
  #end

  # using for each loop to calculate the sum of all elements in the array
  arr.each do |ele|
     sum += ele;
  end

  # using while loop to calculate the sum of all elements in the array
  #idx = 0;
  #while idx < arr.length
  #  sum += arr[idx];
  #  idx += 1;
  #end

    sum;
end

arr = [1,2,3,4,5,6,7,8,9,10,11];
result = arraySum(arr);
puts "Sum of input #{arr} is #{result}";