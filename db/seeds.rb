# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Administrator.create(name: "mobikasa", email: "admin123@mobikasa.com", password: "12345678")
puts "admin created"
BirthPlan.create(title: "BirthPlan 1")
puts "BirthPlan created"