# The input file is a text file representing seats, with floor being represented by '.'
# empty seats by 'L' and occupied_seats by '#'. To start with, all seats are empty.
# Then over a series of iterations, the seats are filled and emptied based on their adjacent
# seats being filled or empty, where adjacent includes diagonal:
# If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
# If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
# Otherwise, the seat's state does not change.
# After a set number of iterations, the seating pattern will stabilize
# The goal of this exercise is to determine how many seats are occupied at that point

input_file = "./day_11_input"

# Convert the string into an array of arrays where each array is one line
# This two-dimensional array will allow us to do the adjacent calulations
# We also get the number of rows and columns (1-based)
position_array = File.read(input_file).split("\n").map(&:chars)

def check_adjacent_chairs(arr, row, col)
  total_rows = arr.length
  total_cols = arr[row].length
  adjacent_chair_hash = Hash.new(0)
  for i in (row - 1..row + 1)
    next if i < 0 || i >= total_rows
    for j in (col - 1..col + 1)
      next if j < 0 || j >= total_cols || (i == row && j == col)
      adjacent_chair_hash[arr[i][j]] += 1
    end
  end
  adjacent_chair_hash
end

p check_adjacent_chairs position_array, 8, 1
