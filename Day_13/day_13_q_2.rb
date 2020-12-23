# The input is two rows - the first row we ignore, the second row a list
# of integers (representing bus numbers) with occasional 'x's
# Each position of the list represents a certain number of minutes after a
# particular start time, t, and the value in that position is a bus number
# that has to run then. We have to find the smallest number t for which
# the rules of the bus arrivals are met

input_file = "./day_13_input"

# Gets just the last line of the input - the list of buses
bus_nums = File.read(input_file).split("\n").last.split(",")

# Creates an array of arrays, where the inner arrays contain pairs of divisors & remainders
# from the bus IDs and their index in the list, which specify the rules our number has to meet

bus_num_rules = bus_nums.each_with_index.map { |num, ind| [num.to_i, ind] if num != "x" }.reject(&:nil?)


# We are using modular division/remainders to get the solution, as this is a reframing of it.
# Effectively, each first element in our arrays, ie the bus IDs, represents a divisor, while the index
# of where that ID appears in the input list is a target remainder. So we have to find a
# number which, given a list of divisors, matches the associated remainders for each divisor.
# Starting from the remainder needed for the first bus ID, we jump by multiples of the first divisor
# until we get to a number which, when divided by the second divisor, gives the second target remainder.
# But now we are matching two remainders with two divisors, and searching for a number
# that matches a third divisor/remainder pair, but still must match the first two rules,
# so we have to search by multiples of both the first and second divisors. Technically,
# we must jump by the LCD of these two numbers, so I will build this.
# In fact, because our bus IDs are coprime (indeed, prime), we could just do the multiple,
# but this is slightly more rigorous - although if we had pairs of numbers with non-trivial
# hcf, then this could cause an infinite loop

interval, cand_num = bus_num_rules.first

bus_num_rules[1..-1].each do |bus_arr|
  new_divisor, new_remainder = bus_arr
  until (cand_num + new_remainder) % new_divisor == 0  do
    cand_num += interval
  end
  interval = interval.lcm(new_divisor)
end

puts "The number #{cand_num} is the minimum number which is offset from each bus by the allocated amount"
