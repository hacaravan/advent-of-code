# The input is two rows - the first row we ignore, the second row a list
# of integers (representing bus numbers) with occasional 'x's
# Each position of the list represents a certain number of minutes after a
# particular start time, t, and the value in that position is a bus number
# that has to run then. We have to find the smallest number t for which
# the rules of the bus arrivals are met

def check_remainder_match(numerator, denominator, remainder)
  numerator % denominator == remainder
end

input_file = "./day_13_input"

# Gets just the last line of the input - the list of buses
bus_nums = File.read(input_file).split("\n").last.split(",")

bus_nums = "7,13,x,x,59,x,31,19".split(",")

# Creates a hash, where the keys are the non-empty bus ID's and the values are the
# index of these in the input, which is equivalent to what the remainder should be when
# dividing each subsequent test number by the bus id

bus_num_rules = bus_nums.each_with_index.map { |num, ind| [num.to_i, ind] if num != "x" }.reject(&:nil?)


# We are using modular division/remainders to get the solution, as this is a reframing of it.
# Effectively, each key in our hash, ie the bus IDs, represents a divisor, while the index
# of where that ID appears in the input list is a target remainder. So we have to find a
# number which, given a list of divisors, matches the associated remainders for each divisor.
# Starting from the remainder needed for the first bus ID, we jump by multiples of the first divisor
# until we get to a number which, when divided by the second divisor, gives the second target remainder.
# But now we are matching two remainders with two divisors, and searching for a number
# that matches a third divisor/remainder pair, but still must match the first two rules,
# so we have to search by multiples of both the first and second divisors. Technically,
# we must jump by the LCD of these two numbers, so I will build this

interval, cand_num = bus_num_rules.first

bus_num_rules[1..-1].each do |bus_arr|
  new_divisor, new_remainder = bus_arr
  until (cand_num + new_remainder) % new_divisor == 0  do
    cand_num += interval
  end
  # puts "candidate number - #{cand_num}, interval - #{interval}, divisor - #{new_divisor}, remainder - #{new_remainder}"
  interval = interval.lcm(new_divisor)
end

puts "The number #{cand_num} is the minimum number which is offset from each bus by the allocated amount"

# Now loop through in steps of the largest of the bus numbers (since it is superflous
# to check smaller steps) until we find a number that satisfies all the remainders
# given all the divisors
# p bus_num_rules

# target = rows_arr.first.to_i
#  = .reject{ |char| char == "x" }.map(&:to_i)
#
# id = 0
# min_multiple = target + bus_nums.max
#
# bus_nums.each do |num|
#   if smallest_multiple_above_target(num, target) < min_multiple
#     id = num
#     min_multiple = smallest_multiple_above_target(num, target)
#   end
# end
#
# wait_time = min_multiple - target
# puts "The earliest bus you can catch is number #{id}, #{wait_time} minutes after you arrive"
# puts "The product of these numbers is #{id * wait_time}"
