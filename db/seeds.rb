# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create a main sample user.
User.create!( firstname: "Example",
              lastname: "User",
              phonenumber: "9999965655",
              email: "usertestapp@yopmail.com",
              password: "foobar",
              password_confirmation: "foobar",
              confirmed_at: Time.now.utc,
              admin: true )

# Generate a bunch of additional users.
29.times do |n|
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  phonenumber = "8888815252"
  email = "usertestapp-#{n+1}@yopmail.com"
  password = "foobar"
  User.create!( firstname: firstname,
                lastname: lastname,
                phonenumber: phonenumber,
                email: email,
                password: password,
                password_confirmation: password,
                confirmed_at: Time.now.utc )
end

# Generate microposts for a subset of users.
users = User.order(:created_at).take(10)
30.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end