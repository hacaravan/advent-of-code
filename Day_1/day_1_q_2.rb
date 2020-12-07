# Read a text file with a list of numbers, line by line
# With the list of numbers this produces, work out which triple adds up to 2020
# Output the product of the three numbers whose sum is 2020

input_file = "./day_1_input"
target_sum = 2020
number_list = File.read(input_file).split.map(&:to_i)

number_list.each do |x|
  number_list.each do |y|
    number_list.each do |z|
      if x + y + z == target_sum
        puts x * y * z, x, y, z
        exit
      end
    end
  end
end
