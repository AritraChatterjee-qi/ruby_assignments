=begin
Write a program to get all the words which are starting from 'ab'.
arr = ["abcde", "abdf", "adeab", "abdgse", "bdefa", "bacdef"]
 Write a program to convert ['abc bcd', 'mno pqr xyz', 'efg'] to ['abc', 'bcd', 'mno', 'pqr', 'xyz', 'efg']
Write a program to get first element which is non zero number.
   arr = [0, 10, 0, 0, 20]
Write a program to check whether all element is non zero? (Method should return either true or false based on given input)
  arr = [0, 10, 0, 0, 20]
Write a program to check whether any element is an even number? (Method should return either true or false based on given input)
  arr = [0, 10, 0, 0, 20]
=end

def filter_starts_with(arr, key)
  unless arr.kind_of?(Array)
    return "Enter a valid Input"
  end

  #return arr.select { |x| x.start_with?(key) }
  return arr.filter_map { |x| x if x.start_with?(key) }
end

def spread_into_array(input)
  unless input.kind_of?(Array)
    return "Enter a valid Input"
  end
  
  return input.flat_map { |x| x.split }
end

def get_fisrt_ele(input)
  unless input.kind_of?(Array)
    return "Enter a valid Input"
  end

  return input.first
end 

def all_elements_zero(input)
  unless input.kind_of?(Array)
    return "Enter a valid Input"
  end  

  return input.all? { |x| x == 0 }
end

def any_elements_even(input)
  unless input.kind_of?(Array)
    return "Enter a valid Input"
  end
  return input.any? { |v| v.even?}
end

puts "1. Filter starts with: #{filter_starts_with(["abcde", "abdf", "adeab", "abdgse", "bdefa", "bacdef"], 'ab')}"
puts "2. Spread into array: #{spread_into_array(['abc bcd','mno pqr xyz', 'efg'])}"
puts "3. Get first element: #{get_fisrt_ele([0, 10, 0, 0, 20])}"
puts "4. Is all Zeros: #{all_elements_zero([0, 10, 0, 0, 20])}"
puts "5. Is any Even: #{any_elements_even([0, 10, 0, 0, 20])}"


