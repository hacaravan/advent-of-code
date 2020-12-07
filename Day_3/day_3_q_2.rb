# We want to go through the text, shifting by different amounts each time
# We are checking for whether there is a '#' or a '.' character
# If it's a '#', representing a tree, then we add to the count
# The pattern is supposed to repeat ad infinitum, but this means we can just use modular arithmetic


def slope_tree_count(input_file, right_step, down_step)
  # Split the initial text file into an array with one line per entry
  lines_split = File.read(input_file).split(/[\r\n]/)
  # All lines are same length so set this now, taken from the length of the first line
  line_length = lines_split[0].length
  line_count = lines_split.length
  tree_count = 0
  # Start from top left-most position, the current_position gives across, down position
  col = 0
  row = 0
  while row < line_count do
    tree_count += 1 if lines_split[row].chars[col] == '#'
    col = (col + right_step) % line_length
    row += down_step
  end
  tree_count
end

input_file = './day_3_input'

check_1 = slope_tree_count(input_file,1,1)
check_2 = slope_tree_count(input_file,3,1)
check_3 = slope_tree_count(input_file,5,1)
check_4 = slope_tree_count(input_file,7,1)
check_5 = slope_tree_count(input_file,1,2)

puts check_1 * check_2 * check_3 * check_4 * check_5
