# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = %w[bob syd nancy jello george nancy grace
           faith unknown lastone]

genders = %w[male female other]

10.times do |num|
  User.create(
    first_name: names[num],
    last_name: names[num].reverse,
    email: "#{names[num]}@example.com",
    password: 'foobar',
    password_confirmation: 'foobar',
    gender: genders.sample,
    birthday: Date.today - 19.years - num.years
  )
end
