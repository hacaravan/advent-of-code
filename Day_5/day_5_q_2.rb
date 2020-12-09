# Convert a seat number for a plane given in a complicated format, which is
# essentially just binary but with different symbols for 1 and 0
# In this question we want to output the maximum row number given on any of the
# tickets in the input file

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

# Don't need the below for the purposes of this exercise
# integer_row_numbers = binary_seat_numbers.map{|binary_string| row_from_binary(binary_string)}
# integer_col_numbers = binary_seat_numbers.map{|binary_string| col_from_binary(binary_string)}
unique_seat_ids = binary_seat_numbers.map{|binary_string| row_from_binary(binary_string) * 8 + col_from_binary(binary_string)}

unique_seat_ids.sort.each_cons(2) { |pair| puts pair[0] + 1 if pair[1] - pair[0] != 1}


## Test conditions
# puts row_from_binary("FFFBBBFRRR".gsub(/[FBLR]/,binary_symbol_hash))
# puts col_from_binary("FFFBBBFRRR".gsub(/[FBLR]/,binary_symbol_hash))
# puts row_from_binary("FFFBBBFRRR".gsub(/[FBLR]/,binary_symbol_hash)) * 8 + col_from_binary("FFFBBBFRRR".gsub(/[FBLR]/,binary_symbol_hash))
