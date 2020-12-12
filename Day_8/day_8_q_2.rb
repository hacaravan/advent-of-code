# Take the instructions from the list in the input file and work out
# what value the accumulator has reached immediately before looping
# I.e., what is the value before an instruction on a particular line is repeated
# Worth remembering that the line number that's put out at the end is 0-based
# This is by no means elegant and it took me a few turns but I got there!
# I had been having trouble because I'd used gsub! to make the swap_line_instructions
# slightly more elegant, but realised it was changing the instructions array when I called
# it from within the jmp_nop_lines_in_first_run.each block, which wasn't intended

def run_instructions(instructions_array, start_line = 0)
  completed_instruction_lines = []
  current_instruction_line = start_line
  accumulator = 0
  reached_end = false

  while true do
    break if completed_instruction_lines.include?(current_instruction_line)
    if instructions_array[current_instruction_line] == nil
      reached_end = true
      break
    end
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

  return {:accumulator => accumulator, :reached_end => reached_end, :completed_instruction_lines => completed_instruction_lines}
end

def swap_line_instructions(line_arr)
  swap_hash = {"jmp" => "nop", "nop" => "jmp"}
  [line_arr.first.gsub(/jmp||nop/, swap_hash), line_arr.last]
end

input_file = "day_8_input"

instructions_array = File.read(input_file).lines.map(&:split)

standard_output = run_instructions(instructions_array)

jmp_nop_lines_in_first_run = standard_output[:completed_instruction_lines].select{ |line| ["jmp", "nop"].include?(instructions_array[line].first) }

changed_instruction_line = 0

jmp_nop_lines_in_first_run.each do |swap_line_number|
  changed_instruction_line = swap_line_number
  alternative_instruction_list = instructions_array.each_with_index.map do |line_arr, line_number|
    line_number == swap_line_number ? swap_line_instructions(line_arr) : line_arr
  end
  # puts "The instruction on line #{changed_instruction_line} has been changed to #{}"
  if run_instructions(alternative_instruction_list, swap_line_number)[:reached_end]
    puts "By swapping the instruction on line #{swap_line_number}, you can reach the end"
    break
  end
end

fixed_instruction_list = instructions_array.each_with_index.map do |line_arr, line_number|
  line_number == changed_instruction_line ? swap_line_instructions(line_arr) : line_arr
end

puts fixed_instruction_list.each_with_index.map{|arr, i| "#{(i + 1).to_s}. #{arr.join(" ")}"}.join("\n")

output_fixed = run_instructions(fixed_instruction_list, 0)

puts "Having successfully completed after #{output_fixed[:completed_instruction_lines].length} instructions, the accumulator value is #{output_fixed[:accumulator]}, and the list of commands was #{output_fixed[:completed_instruction_lines]}"
