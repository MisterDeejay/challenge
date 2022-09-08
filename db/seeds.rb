# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Subscriber.create(
  [
    {
      name: "Rick Sanchez",
      email: "rickc137@citadel.com",
      subscribed: "true"
    },
    {
      name: "Morty Smith",
      email: "morty.smith@gmail.com",
      subscribed: "false"
    },
    {
      name: "Jerry Smith",
      email: "jerry.smith@aol.com",
      subscribed: "true"
    },
    {
      name: "Beth Smith",
      email: "beth.smith@gmail.com",
      subscribed: "true"
    },
    {
      name: "Summer Smith",
      email: "summer.smith@gmail.com",
      subscribed: "true"
    },
    {
      name: "Bird Person",
      email: "bird.person@birdworld.com",
      subscribed: "true"
    }
  ]
)
