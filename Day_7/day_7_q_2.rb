# From a long list of rules on which bags can contain which other bags,
# determine how many total bags will be inside a given bag, in this case shiny gold

input_file = './day_7_input'

# This is list of all bags together with rules for what they can contain
bag_rules_list = File.read(input_file).split("\n")

# This is list of all the different bags, ignoring the rules attached to them
# The list is already unique because of how the input file is set out
bags_list = bag_rules_list.map { |line| line.partition(" bags").first }

bag_container_hash = {}

bags_list.each { |bag| bag_container_hash[bag] = [] }

# The below adds all the bags that each bag immediately contains, the same number of times as they are contained

bag_rules_list.each do |line|
  container_bag = line.partition(" bags").first
  contained_bags = line.partition("contain ").last.split(/[.,] *|bags*/).map(&:strip).reject{|bag| bag.empty? || bag == "no other"}
  contained_bags.each do |bag_with_count|
    count = bag_with_count.partition(/\d /).reject(&:empty?).first.to_i
    bag = bag_with_count.partition(/\d /).last
    count.times { bag_container_hash[container_bag] << bag }
  end
end


# Run through and add all the bags that are contained in each bag that is contained by the given bag,
# then the bags that those contain, and so on until you get to bags which don't hold any others
# This is currently incredibly inefficient
check_bag = "shiny gold"
pass = 0
while true do
  initial_array = bag_container_hash[check_bag]
  new_array = bag_container_hash[check_bag]
  initial_array.each {|bag| new_array += bag_container_hash[bag]}
  puts "There are #{new_array.count} contained bags on pass number #{pass}"
  bag_container_hash[check_bag] = new_array
  break if bag_container_hash[check_bag] == initial_array
  pass += 1
end

puts "There are #{bag_container_hash[check_bag].count} total bags contained within the #{check_bag} bag"
