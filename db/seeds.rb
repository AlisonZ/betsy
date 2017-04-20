# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# READ ME:
# you may want to delete all users you have and all products you have
# the products have user ids 1-10, because there are 10 users in the seed data
# but if you don't care, don't worry about it!

require 'csv'

CSV.read("db/users.csv", headers: true).map do |line|
  new_user = User.create(username: line[0], email: line[1])
  if !new_user.id
    puts "couldn't create user #{new_user.username}"
  end
end


CSV.read("db/products.csv", headers: true).map do |line|
  new_product = Product.create(user_id: line[0].to_i, name: line[1], description: line[2], price: line[3].to_f.round(2), photo_url: line[4], stock: line[5].to_i)
  if !new_product.id
    puts "couldn't create product #{new_product.name}"
    puts new_product.errors.messages
  end
end
