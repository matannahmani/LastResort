# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "here are some seeds"

UserStructure.destroy_all
Structure.destroy_all
CacheResource.destroy_all
UserResource.destroy_all
User.destroy_all
Resource.destroy_all
Unit.destroy_all

bob = Unit.new(
name: "Cú Chulainn",
rarity: "s",
speciality: "lancer",
range: 50,
hp: 300,
attack: 60,
defense: 25)
bob.save!

sue = Unit.new(
name: "Elizabeth Báthory",
rarity: "a",
speciality: "lancer",
range: 35,
hp: 250,
attack: 25,
defense: 10)
sue.save!

tim = Unit.new(
name: "Musashibō Benkei",
rarity: "b",
speciality: "lancer",
range: 35,
hp: 105,
attack: 25,
defense: 15)
tim.save!

al = Unit.new(
name: "Enkidu",
rarity: "b",
speciality: "lancer",
range: 30,
hp: 100,
attack: 40,
defense: 30)
al.save!

kat = Unit.new(
name: "King Salomn",
rarity: "ss",
speciality: "mage",
range: 60,
hp: 200,
attack: 250,
defense: 50)
kat.save!

Unit.create(
name: "Artuhria",
rarity: "ss",
speciality: "saber",
range: 20,
hp: 700,
attack: 120,
defense: 60)

Unit.create(
name: "Merlin",
rarity: "ss",
speciality: "mage",
range: 45,
hp: 300,
attack: 100,
defense: 50)

rob = Unit.new(
name: "Gilles de Rais",
rarity: "a",
speciality: "mage",
range: 30,
hp: 250,
attack: 25,
defense: 15)
rob.save!

bill = Unit.new(
name: "Gilgamesh",
rarity: "b",
speciality: "mage",
range: 30,
hp: 100,
attack: 20,
defense: 10)
bill.save!

dude = Unit.new(
name: "Leonardo Da Vinci",
rarity: "b",
speciality: "mage",
range: 15,
hp: 100,
attack: 25,
defense: 10)
dude.save!


Resource.create!(name: 'wood', exchange: 20)
Resource.create!(name: 'water', exchange: 20)
Resource.create!(name: 'iron', exchange: 20)
Resource.create!(name: 'gold', exchange: 20)
Structure.create!(unit_name: 'Barracks', wood: 20, water: 20, iron: 0, gold: 40, hp: 200, attack: 200,range: 60)
Structure.create!(unit_name: 'Boat', wood: 10, water: 0, iron: 0, gold: 40, hp: 200, attack: 200,range: 60)
Structure.create!(unit_name: 'Medic', wood: 200, water: 20, iron: 0, gold: 40, hp: 200, attack: 200,range: 60)
Structure.create!(unit_name: 'Wheel', wood: 20, water: 20, iron: 0, gold: 40, hp: 200, attack: 200,range: 60)
puts "seeded!"
puts "Seeded #{Resource.all.count} resources"


User.create!(email: 'bob@bob.bob', password: '123456', nickname: 'bobby')
puts "Created user bob@bob.bob"
