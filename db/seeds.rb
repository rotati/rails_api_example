# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Property.destroy_all

Property.create!(name: "Dadouland", province: "Kandal", width: 15, length: 400)
Property.create!(name: "Aeon Mall", province: "Kandal", width: 200, length: 400)
Property.create!(name: "Build Bright University (Battambang)", province: "Battambang", width: 25, length: 200)
