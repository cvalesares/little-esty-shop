# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BulkDiscount.create(discount: 10.00, quantity_threshold: 10, merchant_id: 1)
BulkDiscount.create(discount: 15.00, quantity_threshold: 20, merchant_id: 1)
BulkDiscount.create(discount: 25.00, quantity_threshold: 30, merchant_id: 1)
