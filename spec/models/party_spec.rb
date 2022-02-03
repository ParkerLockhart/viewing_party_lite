require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:users).through(:party_users) }
  end

  describe 'instance methods' do

    describe '#movie' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_result('dune')[0].id
          movie = facace.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id)

          expect(party.movie).to eq(movie)
        end
      end
    end

    describe '#movie_title' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_result('dune')[0].id
          movie = facace.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id)

          expect(party.movie_title).to eq("Dune")
        end
      end
    end

    describe '#movie_poster' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_result('dune')[0].id
          movie = facace.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id)

          expect(party.movie_poster).to eq("https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg")
        end
      end
    end
  end
end
