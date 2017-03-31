# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

o = Organizer.first
t = o.tournaments.create(name: "Seeded Tourney")
p1 = t.phases.create({name: "Phase 1", from: 20.days.ago, until: 5.days.ago})
p2 = t.phases.create({name: "Phase 2", from: 5.days.ago, until: 5.days.from_now})
participants = %w(
Aardvark
Albatross
Alligator
Alpaca
Ant
Anteater
Antelope
Ape
Armadillo
Ass
Baboon
Badger
Barracuda
Bat
Bear
Beaver
Bee
Bison
Boar
Buffalo
Galago
Butterfly
Camel
Caribou
Cat
Caterpillar
Cattle
Chamois
Cheetah
Chicken
Chimpanzee
Chinchilla
Chough
Clam
Cobra
Cockroach
Cod
Cormorant
Coyote
Crab
Crane
Crocodile
Crow
Curlew
Deer
Dinosaur
Dog
Dogfish
Dolphin
Donkey
Dotterel
Dove
Dragonfly
Duck
Dugong
Dunlin
Eagle
Echidna
Eel
Eland
Elephant
Elephant seal
Elk
Emu
Falcon
Ferret
Finch
Fish
Flamingo
Fly
Fox
Frog
Gaur
Gazelle
Gerbil
Giant Panda
Giraffe
Gnat
Gnu
Goat
Goose
Goldfinch
Goldfish
Gorilla
Goshawk
Grasshopper
Grouse
Guanaco
Guinea fowl
Guinea pig
Gull
Hamster
Hare
Hawk
Hedgehog
Heron
Herring
Hippopotamus
Hornet
Horse
Human
Hummingbird
Hyena
Jackal
Jaguar
Jay
Jay, Blue
Jellyfish
Kangaroo
Koala
Komodo dragon
Kouprey
Kudu
Lapwing
Lark
Lemur
Leopard
Lion
Llama
Lobster
Locust
Loris
Louse
Lyrebird
Magpie
Mallard
Manatee
Marten
Meerkat
Mink
Mole
Monkey
Moose
Mouse
Mosquito
Mule
Narwhal
Newt
Nightingale
Octopus
Okapi
Opossum
Oryx
Ostrich
Otter
Owl
Ox
Oyster
Panther
Parrot
Partridge
Peafowl
Pelican
Penguin
Pheasant
Pig
Pigeon
Pony
Porcupine
Porpoise
Prairie Dog
Quail
Quelea
Rabbit
Raccoon
Rail
Ram
Rat
Raven
Red deer
Red panda
Reindeer
Rhinoceros
Rook
Ruff
Salamander
Salmon
Sand Dollar
Sandpiper
Sardine
Scorpion
Sea lion
Sea Urchin
Seahorse
Seal
Shark
Sheep
Shrew
Shrimp
Skunk
Snail
Snake
Spider
Squid
Squirrel
Starling
Stingray
Stinkbug
Stork
Swallow
Swan
Tapir
Tarsier
Termite
Tiger
Toad
Trout
Turkey
Turtle
Vicuña
Viper
Vulture
Wallaby
Walrus
Wasp
Water buffalo
Weasel
Whale
Wolf
Wolverine
Wombat
Woodcock
Woodpecker
Worm
Wren
Yak
Zebra
) 
5.times do |i|
  m = p1.matches.create({from: (p1.from + i.hours), until: (p1.from + (i+1).hours), place: "Room 1"})
  pt1, pt2 = participants.sample(2)
  m.participants.create(name: pt1, result: rand(5))
  m.participants.create(name: pt2, result: rand(5))
end
5.times do |i|
  m = p2.matches.create({from: (p2.from + i.hours), until: (p2.from + (i+1).hours), place: "Room 1"})
  pt1, pt2 = participants.sample(2)
  m.participants.create(name: pt1, result: rand(5))
  m.participants.create(name: pt2, result: rand(5))
end
#AdminUser.create!(email: 'admin@kandanda.ch', password: 'password', password_confirmation: 'password')
