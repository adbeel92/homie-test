# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    name { "Departamento en #{Faker::Address.city}" }
    description { Faker::Lorem.paragraphs(number: 2).join("\n\n") }
    rental_price { Faker::Commerce.price(range: 1_000..50_000) }
    status { Property.statuses.keys.sample }
    owner
  end
end
