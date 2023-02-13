# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
employees = Employee.create!([{email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'},{email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'},{email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'},{email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'},{email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'}])
kudos = Kudo.create!([{
  title: Faker::Adjective.positive,
  content: Faker::Company.bs,
  giver: Employee.create!(email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'),
  receiver: Employee.create(email: Faker::Internet.email(domain: 'gmail.com'), password: 'password')
}, {
  title: Faker::Adjective.positive,
  content: Faker::Company.bs,
  giver: Employee.create(email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'),
  receiver: Employee.create(email: Faker::Internet.email(domain: 'gmail.com'), password: 'password')
}, {
  title: Faker::Adjective.positive,
  content: Faker::Company.bs,
  giver: Employee.create(email: Faker::Internet.email(domain: 'gmail.com'), password: 'password'),
  receiver: Employee.create(email: Faker::Internet.email(domain: 'gmail.com'), password: 'password')
}])
admins = Admin.create!([{
  email: Faker::Internet.email(domain: 'gmail.com'),
  password: 'password'
  }])
