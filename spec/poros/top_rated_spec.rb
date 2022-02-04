require 'rails_helper'

RSpec.describe TopRated do
  it 'exists' do
    data = {
      id: 1,
      title: "Dune",
      vote_average: "7.9"
    }

    top_rated = TopRated.new(data)

    expect(top_rated).to be_instance_of(TopRated)
    expect(top_rated.movie_id).to eq(1)
    expect(top_rated.title).to eq("Dune")
    expect(top_rated.vote_average).to eq("7.9")
  end
end
