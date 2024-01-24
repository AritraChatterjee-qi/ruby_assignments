# Write a program to convert { a: 12, b: 23, c: 34 } to { 12 => "a", 23 => "b", 34 => "c" }

# returns a new Hash Obj
def swap_key_val_01(my_hash) 
  is_hash = my_hash.kind_of?(Hash)
  unless is_hash
    return "ERROR! Fn input must be an array"
  end

  res_hash = Hash.new
  my_hash.each do |key, val|
    res_hash[val] = key
  end

  res_hash
end

# returns the old Hash Obj
def swap_key_val_02(my_hash) 
  is_hash = my_hash.kind_of?(Hash)
  unless is_hash
    return "ERROR! Fn input must be an array"
  end

  #p my_hash.to_a
  my_hash.to_a.each do |key_val|
    my_hash[key_val[1]] = key_val[0]
    my_hash.delete(key_val[0])
  end
  
  my_hash
end

# returns a new Hash Obj
def swap_key_val_03(my_hash)
  is_hash = my_hash.kind_of?(Hash)
  unless is_hash
    return "ERROR! Fn input must be an array"
  end
  my_hash.invert
end



# my_hash_00 = { "a" => 12, "b" => 23, "c" => 34 }
my_hash_00 = { a: 12, b: 23, c: 34 }
puts "Input Hash: #{my_hash_00} with obj_id: #{my_hash_00.object_id}"

puts ""

my_hash_01 = swap_key_val_01(my_hash_00)
puts "Output_01: Hash: #{my_hash_01} with obj_id: #{my_hash_01.object_id}"

puts ""

my_hash_03 = swap_key_val_03(my_hash_00)
puts "Output_03: Hash: #{my_hash_03} with obj_id: #{my_hash_03.object_id}"

puts ""

my_hash_02 = swap_key_val_02(my_hash_00)
puts "Output_02: Hash: #{my_hash_02} with obj_id: #{my_hash_02.object_id}"