require 'factory_bot_rails'
require 'faker'
FactoryBot.define do
  factory :post do
    association :user, factory: :user
    title { Faker::App.name }
    description { Faker::Name.name }
    body { Faker::Markdown.emphasis }
  end
end
