# The input is two rows - the first row is a number, the second row a list
# of integers (representing bus numbers) with occasional 'x's
# Effectively, we have to find the integer from the second row list which has a multiple
# which is the smallest greater than the first row integer

def smallest_multiple_above_target(check_num, target)
  return target if target % check_num == 0
  (target / check_num + 1) * check_num
end

input_file = "./day_13_input"

rows_arr = File.read(input_file).split("\n")
target = rows_arr.first.to_i
bus_nums = rows_arr.last.split(",").reject{ |char| char == "x" }.map(&:to_i)

p smallest_multiple_above_target(3, 10)
