# Given a list of instructions for (decimal) numbers to save in (decimal) memory locations
# and bitmasks to change particular bits of a number, determine what the sum of all
# the values stored in memory is


# This method uses bitwise and/or ("|" and "&") which compare integers' binary representations
# where the result of a | b is 0 in each bit which is 0 in both a and b's binary representation
# and 1 in all other bits. Conversely, a & b gives 1s only when both a and b have 1 in that bit
# The | operation below converts bits to 1 where they are 1s in the bitmask,
# and the & puts 0s where there are 0s in the bitmask. Since 'do nothing' is represented
# by an x in the bitmask, we have to sub this out for the equivalent 'do nothing'
# bit for each operation - 0 | a = a for all a, 1 & b = b for all b

def apply_bitmask(original_num, bitmask)
  original_num = original_num | bitmask.gsub("X", "0").to_i(2)
  original_num & bitmask.gsub("X", "1").to_i(2)
end

def change_mask(new_mask)
  @mask = new_mask
end

def update_memory_hash(location, value)
  @memory_hash[location] = apply_bitmask(value, @mask)
end

def read_instruction(line)
  line_arr = line.split(/[\s\[\]=]/).reject(&:empty?)
  instruction = line_arr.first
  change_mask(line_arr.last) if instruction == "mask"
  update_memory_hash(line_arr[1].to_i, line_arr[2].to_i) if instruction == "mem"
end

@mask, @memory_hash = "", {}

input_file = "./day_14_input"

File.read(input_file).each_line { |line| read_instruction(line) }

value_sum = @memory_hash.values.reduce(0, :+)

puts "The sum of all stored values is #{value_sum}, or in binary #{value_sum.to_s(2)}"
