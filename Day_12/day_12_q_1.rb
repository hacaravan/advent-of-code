# Given a list of instructions of N/S/E/W (Move in given direction without rotating),
# Right/Left (Rotate cw/acw without moving) and Forward (move in current direction),
# work out where you end up, relative to the start point

def vector_addition(v_1, unit_v, scalar)
  v_2 = unit_v.map { |dir| dir * scalar }
  [v_1, v_2].transpose.map(&:sum)
end


input_file = "./day_12_input"

# Create array of arrays - each with a letter/number pair with the instructions
instruction_list = File.read(input_file).split("\n").map { |row| row.partition(/\d+/).reject(&:empty?) }

rl_choices = instruction_list.select { |row| row.first.match?(/[LR]/)}.map { |row| row.last}

# Convert the different angles (with 0 = due east and moving CW around the compass) to unit vectors in format [E, N]
angle_directions = { 0 => [1, 0], 90 => [0, -1], 180 => [-1, 0], 270 => [0, 1],
                    :E => [1,0], :S => [0, -1], :W => [-1, 0], :N => [0, 1]}

angle = 0 # start off facing East (i.e. 0 degrees)
direction = angle_directions[angle]
coordinates = [0, 0] # start off at the centre

instruction_list.each do |row|
  instruction = row.first
  value = row.last.to_i
  if ["L", "R"].include? instruction
    angle = instruction == "L" ? (angle - value) % 360 : (angle + value) % 360
    direction = angle_directions[angle]
  else
    vector = instruction == "F" ? direction : angle_directions[instruction.to_sym]
    coordinates = vector_addition(coordinates, vector, value)
  end
end

p "Final coordinates - #{coordinates}, Manhattan Distance #{coordinates.first.abs + coordinates.last.abs}"
