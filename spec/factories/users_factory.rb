# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email)     { |n| "user#{n}@example.com" }
    password             { 'password' }
    first_name           { 'Jack' }
    last_name            { 'Sparrow' }
    role                 { 'admin' }
    status               { 'active' }
    signature            { nil }

    organization
  end
end
