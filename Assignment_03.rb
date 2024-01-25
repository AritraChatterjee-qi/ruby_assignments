#Question
=begin 
Suppose you have some student id & their marks, Now you have to group the marks based on id & calculate the total marks
[{ id: 1, marks: 80}, { id: 2, marks: 60 }, { id: 1, marks: 60}, { id: 2, marks: 90}]
 
expected output:
=> { 1 => { total: 140 }, 2 => { total: 150 } }
You can use group_by, each, sum etc methods as per your need
=end

def group_total_marks(marks)
  unless marks.kind_of?(Array)
    return "Enter an array input"
  end

  res = Hash.new
  temp = marks.group_by { |x| x[:id] }
  temp.each do |k,v_arr|
    total = 0

    v_arr.each do |x|
      total += x[:marks]
    end
    
    res[k] = { total:  total }
  end
  
  
  res
end

input = [{ id: 1, marks: 80}, { id: 2, marks: 60 }, { id: 1, marks: 60}, { id: 2, marks: 90}]
output = group_total_marks(input)
puts "Input: #{input}"
puts "Output: #{output}"

