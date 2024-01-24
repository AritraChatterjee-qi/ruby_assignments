def arraySum(arr)
  isArray = arr.kind_of?(Array)
  if !isArray
    return "ERROR! Fn input must be an array"
  end

  sum = 0;

  # for loop
  #for i in 0...arr.length
  #  sum += arr[i];
  #end

  # for in loop
  #for ele in arr
  #    sum += ele;
  #end

  # for each loop
  arr.each do |ele|
     sum += ele;
  end

  # while loop
  #idx = 0;
  #while idx < arr.length
  #  sum += arr[idx];
  #  idx += 1;
  #end

    sum;
end

ar = [1,2,3,4,5,6,7,8,9,10];
res = arraySum(ar);
puts "Sum of input #{ar} is #{res}";