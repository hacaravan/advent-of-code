# Read a text file with a list of numbers, line by line
# With the list of numbers this produces, work out which pair adds up to 2020
# Output the product of the two numbers whose sum is 2020

input_file = "./day_1_input"
target_sum = 2020
number_list = File.read(input_file).split.map(&:to_i)

number_list.each do |x|
  number_list.each do |y|
    if x + y == target_sum
      puts x*y, x, y
      exit
    end
  end
end
