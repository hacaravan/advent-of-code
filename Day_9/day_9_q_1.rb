# Take the list of numbers as input
# The first 25 numbers are a seed, and then after that each number should be the
# sum of two of the 25 preceding numbers
# In this exercise we need to find the first number in the list which doesn't fit
# the pattern

input_file = "./day_9_input"

numbers_arr = File.read(input_file).split("\n").map(&:to_i)


# The below takes the array, then checks the cartesian product of itself,and sums each pair of numbers [a,b]
# (having already excluded the case [a,a] where both numbers are equal) to see if the goal is in there
def check_array_for_sum(arr, goal)
  arr.product(arr).reject{|pair| pair.first == pair.last}.map{ |pair| pair.reduce(0, :+)}.include?(goal)
end

check_index = 25

while check_index < numbers_arr.length do
  if !check_array_for_sum(numbers_arr[(check_index - 25)..(check_index-1)], numbers_arr[check_index])
    puts "Number #{numbers_arr[check_index]}, the number in position #{check_index + 1}, does not fit the rules"
  end
  check_index += 1
end
