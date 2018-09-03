require 'faker'

user = User.create!(email: 'test_user@email.com', password: 'testpassword')

100.times do |n|
  Post.create(user: user, title: "#{Faker::Book.title} - #{n+=1}", content: Faker::Lorem.paragraph)
end
