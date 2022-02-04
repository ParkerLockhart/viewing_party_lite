require 'rails_helper'

RSpec.describe Result do
  it 'exists' do
    data = {
      id: 1,
      title: "Dune",
      vote_average: "7.9"
    }

    result = Result.new(data)

    expect(result).to be_instance_of(Result)
    expect(result.movie_id).to eq(1)
    expect(result.title).to eq("Dune")
    expect(result.vote_average).to eq("7.9")
  end
end
