FactoryBot.define do
  factory :party do
    movie_id { 0 }
    duration { 120 }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }

    transient do
      host { create(:user) }
    end
    after(:create) do |party, evaluator|
      create(:party_user, user: evaluator.host, party: party, host: true)
    end

    factory :party_with_viewers do
      transient do
        viewer_count { 3 }
        viewers { create_list(:user, viewer_count) }
      end

      after(:create) do |party, evaluator|
        evaluator.viewers.each do |viewer|
          create(:party_user, party: party, user: viewer, host: false)
        end
      end
    end
  end
end
