# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.paragraph }
  end
end
