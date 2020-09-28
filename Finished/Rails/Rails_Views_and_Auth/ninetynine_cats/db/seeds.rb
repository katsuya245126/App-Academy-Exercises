# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

one = Cat.create!(name: 'One', sex: 'M', birth_date: '2015/09/03', color: 'Black', description: 'Number one')
two = Cat.create!(name: 'Two', sex: 'F', birth_date: '2016/09/03', color: 'White', description: 'Number two')
three = Cat.create!(name: 'Three', sex: 'M', birth_date: '2017/09/03', color: 'Orange', description: 'Number three')
four = Cat.create!(name: 'Four', sex: 'F', birth_date: '2018/09/03', color: 'Brown', description: 'Number four')
five = Cat.create!(name: 'Five', sex: 'M', birth_date: '2019/09/03', color: 'Black', description: 'Number five')

CatRentalRequest.create!(cat_id: one.id, start_date: '2016/1/1', end_date: '2017/1/1')