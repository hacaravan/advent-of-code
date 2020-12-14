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

position_array = "L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL".split("\n").map(&:chars)

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

def iterate_seating_rules(arr)
  total_rows = arr.length
  total_cols = arr.first.length
  new_arr = []
  empty = "L"
  filled = "#"
  floor = "."
  arr.each {|row| new_arr << row.dup}
  for i in (0...total_rows)
    for j in (0...total_cols)
      seat_type = arr[i][j]
      next if seat_type == floor
      seat_type = filled if seat_type == empty && check_adjacent_chairs(arr, i, j)[filled] == 0
      seat_type = empty if seat_type == filled && check_adjacent_chairs(arr, i, j)[filled] >= 4
      new_arr[i][j] = seat_type
    end
  end
  new_arr
end

# puts iterate_seating_rules(position_array).map(&:join).join("\n")

iteration_count = 0

while true do
  puts position_array.is_a?(Array)
  new_arr = iterate_seating_rules(position_array)
  break if new_arr == position_array
  position_array = new_arr
  iteration_count +=1
end

filled = "#"
total_filled_chairs = position_array.map{ |row| row.count(filled)}.reduce(0, :+)
puts "After #{iteration_count} iterations, the seating has now stabilized, with #{total_filled_chairs} filled chairs"
