# Given a list of instructions for (decimal) numbers to save in (decimal) memory locations
# and bitmasks to change particular bits of a number, determine what the sum of all
# the values stored in memory is

# def to_36_bit(decimal_num)
#   "%036b" % decimal_num
# end
#
# def to_decimal(binary_num)
#   binary_num.to_s.to_i(2)
# end

# This method uses bitwise and/or ("|" and "&") which compare integers' binary representations
# where the result of a | b is 0 in each bit which is 0 in both a and b's binary representation
# and 1 in all other bits. Conversely, a & b gives 1s only when both a and b have 1 in that bit
def apply_bitmask(original_num, bitmask)
  original_num = original_num | bitmask.gsub("X", "0").to_i(2) # the 1s from the bitmask are added, replace x with 0 since this preserves in or
  original_num & bitmask.gsub("X", "1").to_i(2) # the 0s from the bitmask are added, replace x with 1 since this preserves in and
end

p apply_bitmask(0, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")
