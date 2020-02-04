# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 使用者形成的同時，預設的折扣也形成了。
User.create(username: 'HanTing', password: 'as789123456',
            email: 'k445566778899k@gmail.com', wallet: 999999999)
User.create(username: 'HanHan', password: 'as789123456',
            email: 'k4455667788990@yahoo.com.tw', wallet: 999999999)

Product.create(name: 'Toast',
               market_price: 100,
               original_price: 120,
               number: 3,
               user_id: 1)

Product.create(name: 'Card',
               market_price: 10,
               original_price: 20,
               number: 5,
               user_id: 2)
