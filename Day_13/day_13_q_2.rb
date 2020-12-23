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
rules_hash = {}
bus_nums.each_with_index { |num, ind| rules_hash[num.to_i] = (num.to_i - ind) % num.to_i if num != "x" }

interval = rules_hash.keys.max
cand_num = rules_hash[interval]
full_match = false


until full_match do
  full_match = rules_hash.keys.reduce(true) { |match_all, divisor| match_all && check_remainder_match(cand_num, divisor, rules_hash[divisor])}
  cand_num += interval
end

# p full_match

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
