# Given a list of instructions for (decimal) numbers to save in (decimal) memory locations
# and bitmasks to change particular bits of a number, determine what the sum of all
# the values stored in memory is. However this time, the 'x' in the mask corresponds to
# a floating bit, and the bit mask applies to the memory address, not the value to be stored.
# The floating bit means that both 0 and 1 are used, so e.g. a mask like 0101xx would save to
# memory locations with 010100, 010101, 010110 and 010111 binary representations

# Simply iterate through the bits of the bitmask and perform the instructions as given
# Outputs an array of all the locations that need to be changed given a supposed input
# memory address, with these converted back to integer from binary string
def apply_bitmask(original_num)
  binary_original = "%036b" % original_num
  out_arr = [""]
  @mask.chars.each_with_index do |char, index|
    out_arr = add_to_all_in_arr(out_arr, "1") if char == "1"
    out_arr = add_to_all_in_arr(out_arr, binary_original[index]) if char == "0"
    out_arr = duplicate_and_add(out_arr) if char == "X"
  end
  out_arr.map{ |location| location.to_i(2)}
end

# Outputs an array where each element of the array has had the given character appended
def add_to_all_in_arr(arr, new_char)
  arr.map { |str| str + new_char }
end

# Outputs an array twice the size of the input where all the strings in the array
# are present, once with 0 appended and once with 1 appended
def duplicate_and_add(arr)
  add_to_all_in_arr(arr, "0") + add_to_all_in_arr(arr, "1")
end

def change_mask(new_mask)
  @mask = new_mask
end

def update_memory_hash(location, value)
  apply_bitmask(location).each { |new_location| @memory_hash[new_location] = value}
end

# Loop through each line of the instructions and call the relevant method
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
