# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a = User.create!(username: 'a', password: 'aaaaaa')
b = User.create!(username: 'b', password: 'bbbbbb')
c = User.create!(username: 'c', password: 'cccccc')
d = User.create!(username: 'd', password: 'dddddd')
e = User.create!(username: 'e', password: 'eeeeee')

one = Cat.create!(name: 'One', sex: 'M', birth_date: '2015/09/03', color: 'Black', description: 'Number one', user_id: a.id)
two = Cat.create!(name: 'Two', sex: 'F', birth_date: '2016/09/03', color: 'White', description: 'Number two', user_id: b.id)
three = Cat.create!(name: 'Three', sex: 'M', birth_date: '2017/09/03', color: 'Orange', description: 'Number three', user_id: c.id)
four = Cat.create!(name: 'Four', sex: 'F', birth_date: '2018/09/03', color: 'Brown', description: 'Number four', user_id: d.id)
five = Cat.create!(name: 'Five', sex: 'M', birth_date: '2019/09/03', color: 'Black', description: 'Number five', user_id: e.id)