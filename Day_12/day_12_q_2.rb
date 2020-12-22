# Most instructions given are now to move a waypoint relative to the ship -
# N/S/E/W (Move the waypoint in the given direction by the value given),
# Right/Left (Rotate the waypoint cw/acw around the ship)
# Forward (move the ship in the direction given by the waypoint's relative position,
# multiplied by the value given, while the waypoint stays static relative to the ship)
# The waypoint starts off 10 units east and 1 unit north of the ship
# Work out where you end up, relative to the start point
require 'matrix'

def vector_addition(v_1, unit_v, scalar)
  v_2 = unit_v.map { |dir| dir * scalar }
  [v_1, v_2].transpose.map(&:sum)
end

def rotate_waypoint(waypoint, degrees)
  rotation_hash = {90 => Matrix[[0, -1],[1, 0]], 180 => Matrix[[-1, 0],[0, -1]], 270 => Matrix[[0, 1], [-1, 0]]}
  (Matrix[waypoint] * rotation_hash[degrees]).to_a.first
end

input_file = "./day_12_input"

# Create array of arrays - each with a letter/number pair with the instructions
instruction_list = File.read(input_file).split("\n").map { |row| row.partition(/\d+/).reject(&:empty?) }

# Convert the different angles (with 0 = due east and moving CW around the compass) to unit vectors in format [E, N]
angle_directions = {:E => [1,0], :S => [0, -1], :W => [-1, 0], :N => [0, 1]}

coordinates = [0, 0] # start off at the centre
waypoint = [10, 1] # this is where the waypoint starts off

instruction_list.each do |row|
  instruction = row.first
  value = row.last.to_i
  # puts "Coordinates are #{coordinates}, waypoint is #{waypoint}, instruction is #{instruction}, value is #{value}"
  if ["L", "R"].include? instruction
    waypoint = rotate_waypoint(waypoint, instruction == "R" ? value : 360 - value)
  elsif instruction == "F"
    coordinates = vector_addition(coordinates, waypoint, value)
  else
    waypoint = vector_addition(waypoint, angle_directions[instruction.to_sym], value)
  end
end

p "Final coordinates - #{coordinates}, Manhattan Distance #{coordinates.first.abs + coordinates.last.abs}"
