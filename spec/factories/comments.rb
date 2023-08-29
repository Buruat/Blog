require 'factory_bot_rails'
require 'faker'
FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    body {Faker::Markdown.emphasis}
  end
end
