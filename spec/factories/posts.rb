# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "#{Faker::Book.title}-#{n}" }
    content { Faker::Lorem.paragraph }
  end
end
