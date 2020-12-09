# Take the input, which represent the positive answers of different people (separated by line)
# in different groups (separated by a blank line) to questions named a-z
# In this exercise, need to work out how many questions in each group that
# everyone in that group responded yes to, then sum the result over all groups


def group_consistent_answers(group)
  group_member_count = group.lines.count
  unique_chars = group.chars.uniq.select{|char| /[a-z]/.match?(char)}
  unique_chars.select{|char| group.count(char) == group_member_count}.length
end

input_file = ('./day_6_input')

answers_by_group = File.read(input_file).split(/\n\n/)

puts answers_by_group.map{|group| group_consistent_answers(group)}.reduce(0, :+)
