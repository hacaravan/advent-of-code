# Check how many valid passports there are in the input file
# Valid passports are those with all seven of the compulsary fields
# But now the compulsary fields have data validation too

# Define a method to check for valid passports to keep the code clean
# Also define a method to do data validation, which must come first

# In this method we are defining the minima and maxima for the different options
# And for ones that have to follow a particular pattern, we define that pattern
# using regular expressions. We then basically cycle through and whichever
# field we have it does the correct validity check
def data_validation(field, value)
  byr_min, byr_max = 1920, 2002
  iyr_min, iyr_max = 2010, 2020
  eyr_min, eyr_max = 2020, 2030
  hgt_min_cm, hgt_max_cm = 150, 193
  hgt_min_in, hgt_max_in = 59, 76
  hcl_length, hcl_regex = 7, /#[0-9a-f]{6}/
  ecl_arr = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  pid_length, pid_regex = 9, /[0-9]{9}/
  case field
  when "byr"
     return value.to_i.between?(byr_min, byr_max)
  when "iyr"
     return value.to_i.between?(iyr_min, iyr_max)
  when "eyr"
     value.to_i.between?(eyr_min, eyr_max)
  when "hgt"
     if value[-2..-1] == "cm"
       return value[0..2].to_i.between?(hgt_min_cm, hgt_max_cm)
     elsif value[-2..-1] == "in"
       return value[0..1].to_i.between?(hgt_min_in, hgt_max_in)
     end
  when "hcl"
    return value.length == hcl_length && value.match?(hcl_regex)
  when "ecl"
    return ecl_arr.include?(value)
  when "pid"
    return value.length == pid_length && value.match(pid_regex)
  end
end

# In this method we check each compulsary field, first that it appears
# and then we check that the data in it is valid
def passport_check(passport)
  compulsary_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  compulsary_fields.each do |field|
    return false if !passport.include?(field + ":")
    value = passport.partition(field + ":").last.partition(/[ \n]/).first
    return false if !data_validation(field, value)
  end
  true
end

# Set the parameters for this particular question

input_file = './day_4_input'
passport_array = File.read(input_file).split("\n\n")
valid_count = 0
invalid_count = 0
total_count = 0

# Check every password in the input file

passport_array.each do |passport|
  passport_check(passport) ? valid_count += 1 : invalid_count += 1
  total_count += 1
end


# Output the result to the screen

puts "#{total_count} passports checked", "#{valid_count} valid", "#{invalid_count} invalid"
