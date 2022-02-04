require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    data = {
      id: 1,
      title: "Dune",
      vote_average: "7.9",
      overview: "Good movie",
      genres: ["Sci fi", "Adventure"],
      runtime: 155,
      poster_path: "dune.jpg"
    }

    dune = Movie.new(data)

    expect(dune).to be_instance_of(Movie)
    expect(dune.id).to eq(1)
    expect(dune.title).to eq("Dune")
    expect(dune.vote_average).to eq("7.9")
    expect(dune.overview).to eq("Good movie")
    expect(dune.genres).to be_an Array
    expect(dune.genres.first).to eq("Sci fi")
    expect(dune.genres.last).to eq("Adventure")
    expect(dune.runtime).to eq(155)
    expect(dune.poster_path).to eq("https://image.tmdb.org/t/p/originaldune.jpg")
  end
end
