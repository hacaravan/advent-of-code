# Take the instructions from the list in the input file and work out
# what value the accumulator has reached immediately before looping
# I.e., what is the value before an instruction on a particular line is repeated
# Worth remembering that the line number that's put out at the end is 0-based

input_file = "day_8_input"

instructions_array = File.read(input_file).lines.map(&:split)

completed_instruction_lines = []
current_instruction_line = 0
accumulator = 0

while true do
  break if completed_instruction_lines.include?(current_instruction_line)
  completed_instruction_lines << current_instruction_line
  instruction = instructions_array[current_instruction_line].first
  instruction_value = instructions_array[current_instruction_line].last.to_i
  if instruction == "acc" then accumulator += instruction_value
  elsif instruction == "jmp"
    current_instruction_line += instruction_value
    next
  end
  current_instruction_line += 1
end

puts "After #{completed_instruction_lines.length} instructions, line #{current_instruction_line} was repeated, and the accumulator value is #{accumulator}"
