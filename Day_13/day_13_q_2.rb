# The input is two rows - the first row we ignore, the second row a list
# of integers (representing bus numbers) with occasional 'x's
# Each position of the list represents a certain number of minutes after a
# particular start time, t, and the value in that position is a bus number
# that has to run then. We have to find the smallest number t for which
# the rules of the bus arrivals are met

def smallest_multiple_above_target(check_num, target)
  return target if target % check_num == 0
  (target / check_num + 1) * check_num
end

input_file = "./day_13_input"

bus_nums = File.read(input_file).split("\n").last.split(",")

bus_num_rules = bus_nums.each_with_index.map { |num, ind| [num.to_i, ind] }.reject { |arr| arr.first == 0 }

p bus_num_rules
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
