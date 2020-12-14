# Take the list of 'joltages' representing adapters, and, by using each 'adapter',
# We still have the condition that we can jump up by 1, 2, or 3 volts, but now we
# have to count how many valid arrangements are (we don't have to use all the adapters)

input_file = "./day_10_input"

sorted_numbers = File.read(input_file).split("\n").map(&:to_i).sort

# Add the 0 valued wall socket to the start, and the device whose value is 3 higher
# than the max of the adapters to the end of the sorted array

sorted_numbers.unshift(0)
sorted_numbers << sorted_numbers.max + 3

number_precedents = Hash.new

# For each number in our list, work out which numbers can immediately precede it
# This will inform how many ways we can get to the final number
sorted_numbers.each do |number|
  number_precedents[number] = sorted_numbers.select {|precedent| precedent < number && precedent >= number - 3}
end

precedent_path_counts = Hash.new(0)

sorted_numbers.each do |number|
  if number == 0
    precedent_path_counts[number] = 1
    next
  end
  number_precedents[number].each {|precedent| precedent_path_counts[number] += precedent_path_counts[precedent]}
end
#
puts precedent_path_counts[sorted_numbers.last]

# Now we have to work out how many ways we can get from 0 to the max value in steps of 1, 2, or 3
# sorted_numbers.each_cons(2) { |pair| jolt_differences[pair.last - pair.first] += 1}

puts "The final tally of how many of each difference is #{jolt_differences}"
puts "The count of 1-differences multiplied by 3-differences is #{jolt_differences[1] * jolt_differences [3]}"
