# Take the list of 'joltages' representing adapters, and, by using each 'adapter',
# count how many 'jumps' of either 1,2, or 3 are made (3 is the max step up that can be made)
# In this exercise we need to count how many

input_file = "./day_10_input"

sorted_numbers = File.read(input_file).split("\n").map(&:to_i).sort

jolt_differences = {1 => 0, 2 => 0, 3 => 0}

# Have to add the smallest number on, as there is a difference to the outlet, which has value of 0
# This minimum number will be one of 1, 2 or 3 (in fact, in our input file, it's 1)
# Also, there is a 3-jolt higher adapter than the max joltage adapter available, so the 3-gaps starts on 1
jolt_differences[sorted_numbers.min] += 1
jolt_differences[3] += 1

# Then for each consecutive pair, add on the difference
sorted_numbers.each_cons(2) { |pair| jolt_differences[pair.last - pair.first] += 1}

puts "The final tally of how many of each difference is #{jolt_differences}"
puts "The count of 1-differences multiplied by 3-differences is #{jolt_differences[1] * jolt_differences [3]}"
