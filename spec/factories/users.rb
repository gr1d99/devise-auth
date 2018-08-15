FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@email.com" }
    password Faker::Internet.unique.password
  end
end
