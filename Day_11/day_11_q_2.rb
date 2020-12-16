# The input file is a text file representing seats, with floor being represented by '.'
# empty seats by 'L' and occupied_seats by '#'. To start with, all seats are empty.
# Then over a series of iterations, the seats are filled and emptied based on the
# seats that can be seen in any of 8 directions (up/down, left/right, diagonals)
# If a seat is empty (L) and no occupied seats are visible to it, the seat becomes occupied.
# If a seat is occupied (#) and five (up from four in q1) or more seats visible from it
# are also occupied, the seat becomes empty.
# Otherwise, the seat's state does not change.
# After a set number of iterations, the seating pattern will stabilize
# The goal of this exercise is to determine how many seats are occupied at that point

input_file = "./day_11_input"

# Convert the string into an array of arrays where each array is one line
# This two-dimensional array will allow us to do the visible calulations
# We also get the number of rows and columns (1-based)
position_array = File.read(input_file).split("\n").map(&:chars)

# position_array = "L.LL.LL.LL
# LLLLLLL.LL
# L.L.L..L..
# LLLL.LL.LL
# L.LL.LL.LL
# L.LLLLL.LL
# ..L.L.....
# LLLLLLLLLL
# L.LLLLLL.L
# L.LLLLL.LL".split("\n").map(&:chars)

def next_visible_chair(arr, row, col, down_move, right_move)
  total_rows = arr.length - 1
  total_cols = arr[row].length - 1
  empty, filled, floor = "L", "#", "."
  i = 0
  while true do
    i += 1
    check_row = row + i * down_move
    check_col = col + i * right_move
    return nil if !check_row.between?(0, total_rows) || !check_col.between?(0, total_cols)
    check_chair = arr[check_row][check_col]
    next if check_chair == floor
    return check_chair
  end
end


def check_visible_chairs(arr, row, col)
  visible_chair_hash = Hash.new(0)
  directions_arr = [-1, 0, 1].product([-1, 0, 1]) - [[0,0]]
  directions_arr.each do |direction|
    visible_chair_hash[next_visible_chair(arr, row, col, direction.first, direction.last)] += 1
  end
  visible_chair_hash
end

def iterate_seating_rules(arr)
  total_rows = arr.length
  total_cols = arr.first.length
  new_arr = []
  empty, filled, floor = "L", "#", "."
  arr.each {|row| new_arr << row.dup}
  # puts new_arr.map{ |row| row.join('')}.join("\n")
  for i in (0...total_rows)
    for j in (0...total_cols)
      seat_type = arr[i][j]
      # p "#{i}, #{j}: #{seat_type}, #{seat_type == empty}, #{check_visible_chairs(arr, i, j)}" if j == 0
      next if seat_type == floor
      seat_type = filled if seat_type == empty && check_visible_chairs(arr, i, j)[filled] == 0
      seat_type = empty if seat_type == filled && check_visible_chairs(arr, i, j)[filled] >= 5
      new_arr[i][j] = seat_type
    end
  end
  new_arr
end

# puts iterate_seating_rules(position_array).map(&:join).join("\n")

# p next_visible_chair(position_array, 97, 0, 1, 1)

# p check_visible_chairs(position_array, 97, 0)

# puts iterate_seating_rules(position_array).map(&:join).join("\n")

# iterate_seating_rules(position_array)

iteration_count = 0

while true do
  # puts position_array.map {|row| row.join('')}.join("\n")
  new_arr = iterate_seating_rules(position_array)
  break if new_arr == position_array
  position_array = new_arr
  iteration_count +=1
end

filled = "#"
total_filled_chairs = position_array.map{ |row| row.count(filled)}.reduce(0, :+)
puts "After #{iteration_count} iterations, the seating has now stabilized, with #{total_filled_chairs} filled chairs"
