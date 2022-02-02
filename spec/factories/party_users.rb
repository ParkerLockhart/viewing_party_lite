FactoryBot.define do
  factory :party_user do
    party
    user
    host {false}
  end
end
