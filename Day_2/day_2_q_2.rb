# Check the list of passwords combined with their policy, and count how many are valid
# Valid passwords are ones where the given character appears between the min and max number of times given

def check_password(check_char, min_count, max_count, password)
  char_count = password.scan(check_char).length
  # puts char_count.between?(min_count, max_count)
  char_count.between?(min_count, max_count)
end

input_file = "./day_2_input"

split_list = File.read(input_file).split(/[\r\n]/)


total_check_count = 0
valid_count = 0
invalid_count = 0

split_list.each do |l|
  check_arr = l.split(/[\-\: ]/).reject(&:empty?)
  # puts check_arr
  min_count = check_arr[0].to_i
  max_count = check_arr[1].to_i
  check_char = check_arr[2]
  password = check_arr[3]
  check_password(check_char, min_count, max_count, password) ? valid_count += 1 : invalid_count += 1
  total_check_count += 1
end

puts "Out of #{total_check_count} total passwords, there were"
puts "#{valid_count} valid"
puts "#{invalid_count} invalid passwords"
# Split the lines of the input file

# For each line, work out the necessary letter and the min and max number of times it can be used

# Check whether the given password matches the min and max criteria

# Count the number of passwords that are valid and invalid
