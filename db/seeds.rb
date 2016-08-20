# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  puts "Seeding the database with default values for development environment."
  puts ""
  puts "  Creating resources."
  r1 = Resource.create(name: "Resource 1")
  puts "    Created Resource 1." if !r1.errors.any?
  r2 = Resource.create(name: "Resource 2", pair_resource_id: r1.id)
  puts "    Created Resource 2." if !r2.errors.any?
  r3 = Resource.create(name: "Resource 3", has_vcon: true)
  puts "    Created Resource 3." if !r3.errors.any?
  puts "  Creating resources completed."
  puts ""
  puts "  Creating users."
  u1 = User.create(name: "User 1")
  puts "    Created User 1." if !u1.errors.any?
  u2 = User.create(name: "User 2")
  puts "    Created User 2." if !u2.errors.any?
  u3 = User.create(name: "User 3")
  puts "    Created User 3." if !u3.errors.any?
  puts "  Creating users completed."
  puts ""
  puts "  Creating resource user distance."
  rud1 = r1.user_distances.create(user_id: u1.id, distance: 1)
  puts "    Created resource 1 user 1 for distance 1." if !rud1.errors.any?
  rud2 = r1.user_distances.create(user_id: u2.id, distance: 3)
  puts "    Created resource 1 user 2 for distance 3." if !rud2.errors.any?
  rud3 = r1.user_distances.create(user_id: u3.id, distance: 5)
  puts "    Created resource 1 user 3 for distance 5." if !rud3.errors.any?
  rud4 = r2.user_distances.create(user_id: u1.id, distance: 3)
  puts "    Created resource 2 user 1 for distance 3." if !rud4.errors.any?
  rud5 = r2.user_distances.create(user_id: u2.id, distance: 1)
  puts "    Created resource 2 user 2 for distance 1." if !rud5.errors.any?
  rud6 = r2.user_distances.create(user_id: u3.id, distance: 3)
  puts "    Created resource 2 user 3 for distance 3." if !rud6.errors.any?
  rud7 = r3.user_distances.create(user_id: u1.id, distance: 5)
  puts "    Created resource 3 user 1 for distance 5." if !rud7.errors.any?
  rud8 = r3.user_distances.create(user_id: u2.id, distance: 3)
  puts "    Created resource 3 user 2 for distance 3." if !rud8.errors.any?
  rud9 = r3.user_distances.create(user_id: u3.id, distance: 1)
  puts "    Created resource 3 user 3 for distance 1." if !rud9.errors.any?
  puts "  Creating resource user distance completed."
  puts ""
  puts "Seeding the database completed."
end