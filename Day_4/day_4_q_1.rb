# Check how many valid passports there are in the input file
# Valid passports are those with all seven of the compulsary fields

# Define a method to check for valid passports to keep the code clean

def passport_check(passport)
  compulsary_fields = ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"]
  compulsary_fields.each do |field|
    return false if !passport.include?(field)
    true
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
