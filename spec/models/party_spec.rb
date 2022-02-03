require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:users).through(:party_users) }
  end

  describe 'instance methods' do
    let!(:user_1) { create(:user) }

    describe '#movie' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_results('dune')[0].movie_id
          movie = facade.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id)

          expect(party.movie.id).to eq(movie.id)
        end
      end
    end

    describe '#movie_title' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_results('dune')[0].movie_id
          movie = facade.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id)

          expect(party.movie_title).to eq("Dune")
        end
      end
    end

    describe '#movie_date and #movie_time' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_results('dune')[0].movie_id
          movie = facade.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

          expect(party.movie_date).to eq("Feb 2, 2022")
          expect(party.movie_time).to eq("6:10 PM")
        end
      end
    end

    describe '#movie_poster' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          facade = MovieFacade.new
          movie_id = facade.movie_results('dune')[0].movie_id
          movie = facade.movie_info(movie_id)
          party = create(:party, host: user_1, movie_id: movie_id)

          expect(party.movie_poster).to eq("https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg")
        end
      end
    end
  end
end
