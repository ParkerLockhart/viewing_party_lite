FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email { "#{name.gsub(/ /, "_")}@email.com" }
  end
end
