# Take the list of numbers as input
# The first 25 numbers are a seed, and then after that each number should be the
# sum of two of the 25 preceding numbers
# In this exercise we need to find some list of contiguous numbers which sum up to the number
# which we found previously which is not the sum of two numbers of its preceding 25

input_file = "./day_9_input"

numbers_arr = File.read(input_file).split("\n").map(&:to_i)


# The below takes the array, then checks the cartesian product of itself,and sums each pair of numbers [a,b]
# (having already excluded the case [a,a] where both numbers are equal) to see if the goal is in there
def check_array_for_sum(arr, goal)
  arr.product(arr).reject{|pair| pair.first == pair.last}.map{ |pair| pair.reduce(0, :+)}.include?(goal)
end

check_index = 25
target_number = 0

while check_index < numbers_arr.length do
  if !check_array_for_sum(numbers_arr[(check_index - 25)..(check_index-1)], numbers_arr[check_index])
    target_number = numbers_arr[check_index]
    break
  end
  check_index += 1
end

numbers_arr.each_with_index do |number, start_index|
  ((start_index + 1)..(numbers_arr.length - 1)).each do |end_index|
    check_array = numbers_arr[start_index..end_index]
    array_sum = check_array.reduce(0, :+)
    break if array_sum > target_number
    if array_sum == target_number
      puts "The list of numbers #{check_array} adds up to #{target_number}"
      puts "The minimum of the list is #{check_array.min} and the max is #{check_array.max}"
      puts "The product of these two numbers is #{check_array.min + check_array.max}"
    end
  next if array_sum > target_number
  end
end
