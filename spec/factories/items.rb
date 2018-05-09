# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    name { Faker::Starwars.character}
    done false
    todo_id nil
  end
end
