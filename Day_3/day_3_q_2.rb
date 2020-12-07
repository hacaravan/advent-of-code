# We want to go through the text, shifting right three and down one each time
# We are checking for whether there is a '#' or a '.' character
# If it's a '#', representing a tree, then we add to the count
# The pattern is supposed to repeat ad infinitum, but this means we can just use modular arithmetic

input_file = './day_3_input'

# Set this as it could be useful to change it in future
right_step = 3

# Split the initial text file into an array with one line per entry
lines_split = File.read(input_file).split(/[\r\n]/)

# All lines are same length so set this now, taken from the length of the first line
line_length = lines_split[0].length

# Start from left-most position, the current_position only gives position along line
current_position = 0

tree_count = 0

lines_split.each do |line|
  tree_count += 1 if line.chars[current_position] == '#'
  current_position = (current_position + right_step) % line_length
end

puts tree_count
