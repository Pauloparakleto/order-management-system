# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryBot.create_list(:order, 20)

index = Order.first.id.to_i

10.times do
  Order.find(index).in_progress!
  index += 1
end

order_in_progress = Order.where(status: :in_progress)
order_in_progress.first.completed!
order_in_progress.second.completed!
order_in_progress.last.completed!

