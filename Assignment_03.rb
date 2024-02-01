=begin 
# Question

Suppose you have some student id & their marks, Now you have to group the marks based on id & calculate the total marks
[{ id: 1, marks: 80}, { id: 2, marks: 60 }, { id: 1, marks: 60}, { id: 2, marks: 90}]
 
expected output:
=> { 1 => { total: 140 }, 2 => { total: 150 } }
You can use group_by, each, sum etc methods as per your need
=end

# This fucntion takes an array of hash<:id,:marks> as argument and returns the a hash containing the id mapped to another hash containing the total marks of that id.
def group_total_marks(marks)
  unless marks.kind_of?(Array)
    return "Enter an array input"
  end

  result = Hash.new
  
  marks.group_by { |x| x[:id] }.each do |key, val|
    result[key] = { total:  val.sum { |x| x[:marks] } }
  end
  
  result
end

input = [{ id: 1, marks: 80}, { id: 2, marks: 60 }, { id: 1, marks: 60}, { id: 2, marks: 90}]
output = group_total_marks(input)
puts "Input: #{input}"
puts "Output: #{output}"