# Take the input, which represent the positive answers of different people (separated by line)
# in different groups (separated by a blank line) to questions named a-z
# In this exercise, need to work out how many questions in each group that at
# least one person in that group responded yes to, then sum the result over all groups

input_file = ('./day_6_input')

answers_by_group = File.read(input_file).split(/\n\n/)

answers_per_group = answers_by_group.map{|answers| answers.chars.uniq.select {|char| /[a-z]/.match?(char)}.length}

puts  answers_per_group.reduce(0, :+)
