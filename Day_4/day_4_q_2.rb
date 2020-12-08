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
     value.between(byr_min, byr_max)
  when "iyr"
     value.between(iyr_min, iyr_max)
  when "eyr"
     value.between(eyr_min, eyr_max)
  when "hgt"
     value.between(hgt_min, hgt_max)
  when "hcl"
     value.length == hcl_length && value.match?(hcl_regex)
  when "ecl"
    ecl_arr.include?(value)
  when "pid"
    value.length = pid_length && value.match(pid_regex)
  end
end

# In this method we first check that all the compulsary fields appear
# and then we check that the data within them is valid
def passport_check(passport)
  compulsary_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  compulsary_fields.each do |field|
    return false if !passport.include?(field + ":")
    # Extract the value from the passport string and pass this and the
  end
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
