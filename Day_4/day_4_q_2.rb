# Check how many valid passports there are in the input file
# Valid passports are those with all seven of the compulsary fields


# First, split the input file into different passports, which are separated by
# two blank lines

def passport_check(passport)
  compulsary_fields = ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"]
  compulsary_fields.each do |field|
    return false if !passport.include?(field)
    true
  end
end


input_file = './day_4_input'
passport_array = File.read(input_file).split("\n\n")
valid_count = 0
invalid_count = 0
total_count = 0

passport_array.each do |passport|
  passport_check(passport) ? valid_count += 1 : invalid_count += 1
  total_count += 1
end

puts "#{total_count} passports checked", "#{valid_count} valid", "#{invalid_count} invalid"
