# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: 'chenruru', password: 'as789123456',
            email: 'chenruru@gmail.com', admin: true)
User.create(username: 'chenhanhan', password: 'as789123456',
            email: 'han@jvdiamondtech.com', admin: true)
