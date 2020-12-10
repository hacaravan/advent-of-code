# From a long list of rules on which bags can contain which other bags,
# determine how many different kind of bags can eventually contain the given bag type
# In this case, a bright gold bag

input_file = './day_7_input'

# This is list of all bags together with rules for what they can contain
bag_rules_list = File.read(input_file).split("\n")

# This is list of all the different bags, ignoring the rules attached to them
# The list is already unique because of how the input file is set out
bags_list = bag_rules_list.map { |line| line.partition(" bags").first }

bag_contained_hash = {}

bags_list.each { |bag| bag_contained_hash[bag] = [] }

# The below adds all the first order container bags for each bag
bag_rules_list.each do |line|
  container_bag = line.partition(" bags").first
  contained_bags = line.partition("contain ").last.split(/\d+ |[.,] *|bags*/).map(&:rstrip).reject{|bag| bag.empty? || bag == "no other"}
  contained_bags.each{ |bag| bag_contained_hash[bag] << container_bag }
end

# Run through and add all the bags that can contain any of the bags that contain the given bag,
# then the bags that contain those, and so on until you get to bags which can't be held in any others
check_bag = "shiny gold"

while true do
  initial_array = bag_contained_hash[check_bag]
  initial_array.each {|bag| bag_contained_hash[check_bag] |= bag_contained_hash[bag]}
  break if bag_contained_hash[check_bag] == initial_array
end

puts "There are #{bag_contained_hash[check_bag].count} bags which can ultimately contain the #{check_bag} bag"
