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

          movie = MovieFacade.get_first_movie('dune')
          party = create(:party, host: user_1, movie_id: movie.id)

          expect(party.movie.id).to eq(movie.id)
        end
      end
    end

    describe '#movie_title' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          movie = MovieFacade.get_first_movie('dune')
          party = create(:party, host: user_1, movie_id: movie.id)

          expect(party.movie_title).to eq("Dune")
        end
      end
    end

    describe '#movie_date and #movie_time' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          movie = MovieFacade.get_first_movie('dune')
          party = create(:party, host: user_1, movie_id: movie.id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

          expect(party.movie_date).to eq("Feb 2, 2022")
          expect(party.movie_time).to eq("6:10 PM")
        end
      end
    end

    describe '#movie_poster' do
      it "returns the movie associated with the party's movie_id" do
        VCR.use_cassette('create_movie_from_search_dune') do
          movie = MovieFacade.get_first_movie('dune')
          party = create(:party, host: user_1, movie_id: movie.id)

          expect(party.movie_poster).to eq("https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg")
        end
      end
    end

    describe '#host' do
      it "returns the host of the party" do
        host = create(:user, name: 'Jeff')
        viewer_1 = create(:user, name: 'Abby')
        viewer_2 = create(:user, name: 'Bob')
        viewer_3 = create(:user, name: 'Charlie')
        viewers = [viewer_1, viewer_2, viewer_3]
        party = create(:party_with_viewers, host: host, viewers: viewers)

        expect(party.host).to eq(host)
      end
    end

    describe '#host_name' do
      it "returns the name of the host of the party" do
        host = create(:user, name: 'Jeff')
        viewer_1 = create(:user, name: 'Abby')
        viewer_2 = create(:user, name: 'Bob')
        viewer_3 = create(:user, name: 'Charlie')
        viewers = [viewer_1, viewer_2, viewer_3]
        party = create(:party_with_viewers, host: host, viewers: viewers)

        expect(party.host_name).to eq('Jeff')
      end
    end

    describe '#viewers' do
      it "returns all viewers who are not the host of the party" do
        host = create(:user, name: 'Jeff')
        viewer_1 = create(:user, name: 'Abby')
        viewer_2 = create(:user, name: 'Bob')
        viewer_3 = create(:user, name: 'Charlie')
        viewers = [viewer_1, viewer_2, viewer_3]
        party = create(:party_with_viewers, host: host, viewers: viewers)

        expect(party.viewers).to eq(viewers)
      end
    end
  end
end
