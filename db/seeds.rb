# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 10.times do  |n|
#   first_name = Faker::Name.name
#   email = "example-#{n+1}@raresapp.com"
#   password = "password"
#   User.create!(first_name: first_name,
#                email: email,
#                password: password)
# end
1.times do |n|
  first_name, last_name = Faker::Name.name.split(" ")
  email = "example-#{n+1}@user-rares-app.org"
  password = "password"
  user_name = "user-#{n+1}"
  
  User.create!(first_name:  first_name,
               last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password,
               user_name: user_name)
end

50.times do
  description = Faker::Lorem.sentence(10)
  User.all.each { |user| user.microposts.create!(description: description, city: "Targu Mures", street: "Ceahlau", number: 12, title: "Demo Title",) }
end
