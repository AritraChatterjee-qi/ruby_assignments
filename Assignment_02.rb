# Write a program to convert { a: 12, b: 23, c: 34 } to { 12 => "a", 23 => "b", 34 => "c" }

# This function takes an hash as argument and returns a new hash object. <Symbol:Integer> to <Integer:String>
def swap_key_val_one(my_hash) 
  is_hash = my_hash.kind_of?(Hash)

  unless is_hash
    return "ERROR! Fn input must be an array"
  end

  res_hash = Hash.new

  my_hash.each do |key, val|
    res_hash[val] = key.to_s
  end

  res_hash
end

# This function takes an hash as argument. Modify and returns the same hash object. <Symbol:Integer> to <Integer:String>
def swap_key_val_two(my_hash) 
  is_hash = my_hash.kind_of?(Hash)
  
  unless is_hash
    return "ERROR! Fn input must be an array"
  end

  my_hash.to_a.each do |key_val|
    my_hash[key_val[1]] = key_val[0].to_s
    my_hash.delete(key_val[0])
  end
  
  my_hash
end

in_hash = { a: 12, b: 23, c: 34 }
puts "Input Hash: #{in_hash} with obj_id: #{in_hash.object_id}"
puts ""
out_hash_one = swap_key_val_one(in_hash)
puts "Output_01: Hash: #{out_hash_one} with obj_id: #{out_hash_one.object_id}"
puts ""
out_hash_two = swap_key_val_two(in_hash)
puts "Output_02: Hash: #{out_hash_two} with obj_id: #{out_hash_two.object_id}"