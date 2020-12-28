# Given a list of instructions for (decimal) numbers to save in (decimal) memory locations
# and bitmasks to change particular bits of a number, determine what the sum of all
# the values stored in memory is. However this time, the 'x' in the mask corresponds to
# a floating bit, and the bit mask applies to the memory address, not the value to be stored.
# The floating bit means that both 0 and 1 are used, so e.g. a mask like 0101xx would save to
# memory locations with 010100, 010101, 010110 and 010111 binary representations


# This method uses bitwise and/or ("|" and "&") which compare integers' binary representations
# where the result of a | b is 0 in each bit which is 0 in both a and b's binary representation
# and 1 in all other bits. Conversely, a & b gives 1s only when both a and b have 1 in that bit
# The | operation below converts bits to 1 where they are 1s in the bitmask,
# and the & puts 0s where there are 0s in the bitmask. Since 'do nothing' is represented
# by an x in the bitmask, we have to sub this out for the equivalent 'do nothing'
# bit for each operation - 0 | a = a for all a, 1 & b = b for all b

def apply_bitmask(original_num)
  binary_original = "%036b" % original_num
  # p binary_original
  out_arr = [""]
  @mask.chars.each_with_index do |char, index|
    out_arr = add_to_all_in_arr(out_arr, "1") if char == "1"
    out_arr = add_to_all_in_arr(out_arr, binary_original[index]) if char == "0"
    out_arr = duplicate_and_add(out_arr) if char == "X"
  end
  out_arr.map{ |location| location.to_i(2)}
end

def add_to_all_in_arr(arr, new_char)
  arr.map { |str| str + new_char }
end

def duplicate_and_add(arr)
  add_to_all_in_arr(arr, "0") + add_to_all_in_arr(arr, "1")
end

def change_mask(new_mask)
  @mask = new_mask
  puts "Mask is #{@mask}"
end

def update_memory_hash(location, value)
  apply_bitmask(location).each { |new_location| @memory_hash[new_location] = value}
end

def read_instruction(line)
  line_arr = line.split(/[\s\[\]=]/).reject(&:empty?)
  instruction = line_arr.first
  change_mask(line_arr.last) if instruction == "mask"
  update_memory_hash(line_arr[1].to_i, line_arr[2].to_i) if instruction == "mem"
end

@mask, @memory_hash = "000000000000000000000000000000X1001X", {}

# p add_to_all_in_arr(duplicate_and_add(["000000000000000000000000000000"]), "1")

p apply_bitmask(42)

# "mask = 000000000000000000000000000000X1001X
# mem[42] = 100
# mask = 00000000000000000000000000000000X0XX
# mem[26] = 1".each_line { |line| read_instruction(line) }

# puts "the output hash is #{@memory_hash}"
# input_file = "./day_14_input"
#
# File.read(input_file).each_line { |line| read_instruction(line) }
#
# value_sum = @memory_hash.values.reduce(0, :+)
#
# puts "The sum of all stored values is #{value_sum}, or in binary #{value_sum.to_s(2)}"
