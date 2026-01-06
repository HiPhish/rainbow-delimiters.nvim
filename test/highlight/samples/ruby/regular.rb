# frozen_string_literal: true

an_array = [[['Hello', 'world!']]] # rubocop:disable Lint/UselessAssignment
a_hash = { 'x' => { 'x' => { 'x' => 'Hello, world!' } } } # rubocop:disable Lint/UselessAssignment

def greeting(name, age)
  age_in_seconds = (((((age * 365))) * 24) * 60) * 60

  puts "Hello, #{name}! You are #{age} years old, which is #{age_in_seconds} in seconds!"
end

puts greeting('Fry', 25)

puts an_array[0][0][1]

[[1], [2], [3]].each { |nums| nums.each { |num| puts num } }
