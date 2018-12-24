# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# probe big num combinatorial(100,2)= 4950
# 100.times do
4.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: 'password'
end
results = [[19, 21], [21, 19], [24, 22], [9, 21]]

# combinatorial(4,2) = (4!)/(2!*2!) = (4*3*2*1)/(4) = 6 games
# 1 vs 2, 1 vs 3, 1 vs 4, 2 vs 3, 2 vs 4, 3 vs 4
# games = 0
# (1..User.count).each do |i|
#   ((i + 1)..User.count).each do |j|
#     puts "jugador #{i} vs jugador #{j}"
#     board = results[rand(0..(results.size - 1))]
#     Game.create player_id: i,
#                 opponent_id: j,
#                 played_at: Time.now + (i + j).days,
#                 player_score: board.first,
#                 opponent_score: board.second
#     games += 1
#
#   end
# end
#
# puts "Number Games: #{games} "
