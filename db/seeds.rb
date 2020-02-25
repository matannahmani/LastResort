# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "here are some seeds"

bob = Unit.new(
name: "bob",
rarity: "s",
speciality: "lancer",
range: 3,
hp: 10,
attack: 2,
defense: 1)
bob.save!

sue = Unit.new(
name: "sue",
rarity: "a",
speciality: "lancer",
range: 3,
hp: 10,
attack: 2,
defense: 1)
sue.save!

tim = Unit.new(
name: "tim",
rarity: "b",
speciality: "lancer",
range: 3,
hp: 10,
attack: 2,
defense: 1)
tim.save!

al = Unit.new(
name: "al",
rarity: "b",
speciality: "lancer",
range: 3,
hp: 10,
attack: 2,
defense: 1)
al.save!

kat = Unit.new(
name: "kat",
rarity: "s",
speciality: "mage",
range: 3,
hp: 10,
attack: 2,
defense: 1)
kat.save!

rob = Unit.new(
name: "rob",
rarity: "a",
speciality: "mage",
range: 3,
hp: 10,
attack: 2,
defense: 1)
rob.save!

bill = Unit.new(
name: "bill",
rarity: "b",
speciality: "mage",
range: 3,
hp: 10,
attack: 2,
defense: 1)
bill.save!

dude = Unit.new(
name: "dude",
rarity: "b",
speciality: "mage",
range: 3,
hp: 10,
attack: 2,
defense: 1)
dude.save!

puts "seeded!"
