# From a long list of rules on which bags can contain which other bags,
# determine how many total bags will be inside a given bag, in this case shiny gold

input_file = './day_7_input'

# This is list of all bags together with rules for what they can contain
bag_rules_list = File.read(input_file).split("\n")

# This is list of all the different bags, ignoring the rules attached to them
# The list is already unique because of how the input file is set out
bags_list = bag_rules_list.map { |line| line.partition(" bags").first }

# Each key in this hash will be one of the bags, and each value will initially be
# an empty hash
bag_container_hash = {}

bags_list.each { |bag| bag_container_hash[bag] = Hash.new(0) }

# We now cycle through all the bag containment rules, so we can update the hashes
# within the bag_container_hash. Each hash, which corresponds to a bag,
# will contain the bags contained within that bag as keys, and the number of times
# each of these contained bags appears in the container bag as values
bag_rules_list.each do |line|
  container_bag = line.partition(" bags").first
  contained_bags = line.partition("contain ").last.split(/[.,] *|bags*/).map(&:strip).reject{|bag| bag.empty? || bag == "no other"}
  contained_bags.each do |bag_with_count|
    count = bag_with_count.partition(/\d /).reject(&:empty?).first.to_i
    bag = bag_with_count.partition(/\d /).last
    bag_container_hash[container_bag][bag] = count
  end
end

# Set the bag which we're checking to see how many bags are ultimately within it
check_bag = "shiny gold"

# initiate an array that (at first) contains the bags directly inside our check_bag as keys,
# and the number of times each bag appears as values.
# We will recursively do this same exercise for each bag within descending layers afterwards
bag_ordered_containment = [bag_container_hash[check_bag]]
order = 0

# Then for the current order we're looking at, create a new hash for the next layer
# of bags down, where the keys are the bags in that layer and the values are how
# many times they are contained in the layer above multiplied by how many times
# those bags in the layer above appear
# This process iterates layer by layer until you have a layer which has no bags within it
while true do
  current_containers = bag_ordered_containment[order]
  break if current_containers.empty?
  next_order_bags = Hash.new(0)
  current_containers.each do |container_bag, container_count|
    contained_bags = bag_container_hash[container_bag]
    contained_bags.each do |contained_bag, contained_count|
      next_order_bags[contained_bag] += container_count * contained_count
    end
  end
  bag_ordered_containment << next_order_bags
  order += 1
end

total_bags_in_check_bag = bag_ordered_containment.map {|hash| hash.values.reduce(0, :+)}.reduce(0, :+)

puts "There are #{total_bags_in_check_bag} bags within #{check_bag} bag"



# puts "There are #{bag_container_hash[check_bag].count} total bags contained within the #{check_bag} bag"
