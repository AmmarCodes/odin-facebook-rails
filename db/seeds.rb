# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

user_ids = []
2.times do
  user = User.create(Faker::Internet.user('username', 'email', 'password'))
  user_ids << user.id
  3.times do
    post = user.posts.create(title: Faker::Quote.robin, content: Faker::Hipster.paragraph(sentence_count: 6))
    2.times do
      post.comments.create(user_id: user_ids.sample, content: Faker::Hipster.paragraph(sentence_count: 1))
    end
  end
end
