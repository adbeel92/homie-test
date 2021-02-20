# frozen_string_literal: true

FactoryBot.define do
  factory :api_admin do
    email { 'test@test.com' }
    password { 'password' }
  end
end
