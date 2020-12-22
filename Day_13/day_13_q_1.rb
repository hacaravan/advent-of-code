# The input is two rows - the first row is a number, the second row a list
# of integers (representing bus numbers) with occasional 'x's
# Effectively, we have to find the integer from the second row list which has a multiple
# which is the smallest greater than the first row integer
# We have to output the ID of the earliest bus, multiplied by the time you have
# to wait for that bus

def smallest_multiple_above_target(check_num, target)
  return target if target % check_num == 0
  (target / check_num + 1) * check_num
end

input_file = "./day_13_input"

rows_arr = File.read(input_file).split("\n")

target = rows_arr.first.to_i
bus_nums = rows_arr.last.split(",").reject{ |char| char == "x" }.map(&:to_i)

id = 0
min_multiple = target + bus_nums.max

bus_nums.each do |num|
  if smallest_multiple_above_target(num, target) < min_multiple
    id = num
    min_multiple = smallest_multiple_above_target(num, target)
  end
end

wait_time = min_multiple - target
puts "The earliest bus you can catch is number #{id}, #{wait_time} minutes after you arrive"
puts "The product of these numbers is #{id * wait_time}"
