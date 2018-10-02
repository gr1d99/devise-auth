require 'faker'

user = User.create!(email: 'test_user@email.com', password: 'testpassword')

100.times do |n|
  post = Post.create(
    user: user,
    title: "#{Faker::Book.title} - #{n+=1}",
    content: "#{Faker::Lorem.paragraph * 10}"
  )
end

Post.all.each do |post|
  5.times.each do
    post.comments.create(comment: Faker::Lorem.paragraph, user: User.first)
  end
end
