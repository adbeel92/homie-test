# frozen_string_literal: true

FactoryBot.define do
  factory :owner do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
