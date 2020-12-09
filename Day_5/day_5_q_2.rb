# Convert a seat number for a plane given in a complicated format, which is
# essentially just binary but with different symbols for 1 and 0
# In this question we want to output the seat id that is missing from the list

def row_from_binary(binary_string)
  binary_string.slice(0,7).to_i(2)
end

def col_from_binary(binary_string)
  binary_string.slice(-3,3).to_i(2)
end

# Create a hash which maps the letters to the equivalent binary digit
binary_symbol_hash = {"F" => "0", "B" => "1", "L" => "0", "R" => "1"}

input_file = "./day_5_input"

binary_seat_numbers = File.read(input_file).split(/\n/).map{|string| string.gsub(/[FBLR]/,binary_symbol_hash)}


unique_seat_ids = binary_seat_numbers.map{|binary_string| row_from_binary(binary_string) * 8 + col_from_binary(binary_string)}

# Running through each consecutive pair of seat ID's (when ordered), puts an ID
# one higher than the lower of the pair if the gap between the pair is more than 1
# This follows from the description of the missing seat as the only missing one not
# either at the front or the back
unique_seat_ids.sort.each_cons(2) { |pair| puts pair[0] + 1 if pair[1] - pair[0] != 1}
