require 'rails_helper'

RSpec.describe 'user dashboard' do
  let!(:user_1) {User.create(name: "Jeff", email: "jeff@email.com")}
  let!(:user_2) {User.create(name: "Amy", email: "amy@email.com")}

  it 'shows page title with user name' do
    visit user_path(user_1)
    expect(page).to have_content("Jeff's Dashboard")
  end

  it 'has a button to discover movies that redirects to a discover page associated with that user ' do
    visit user_path(user_1)
    expect(page).to have_button("Discover Movies")

    click_button "Discover Movies"

    expect(current_path).to eq("/users/#{user_1.id}/discover")
  end

  describe 'viewing party sections' do

    it "has a movie image" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        movie = MovieFacade.get_first_movie('dune')
        party = create(:party, host: user_1, movie_id: movie.id)

        visit user_path(user_1)

        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg']")
      end
    end

    it "has a title that links to the movie show page" do
      VCR.use_cassette('create_movie_from_search_dune3') do
        movie = MovieFacade.get_first_movie('dune')
        party = create(:party, host: user_1, movie_id: movie.id)

        visit user_path(user_1)

        click_link "Title: Dune"
        expect(current_path).to eq("/users/#{user_1.id}/movies/#{movie.id}")
      end
    end

    it "has date and time of event" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        movie = MovieFacade.get_first_movie('dune')
        party = create(:party, host: user_1, movie_id: movie.id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

        visit user_path(user_1)

        expect(page).to have_content("Date: Feb 2, 2022")
        expect(page).to have_content("Time: 6:10 PM")
      end
    end

    it "lists the host" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        movie = MovieFacade.get_first_movie('dune')
        party = create(:party_with_viewers, host: user_1, viewer_count: 4, movie_id: movie.id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

        visit user_path(user_1)

        expect(page).to have_content("Hosting")
      end
    end

    it "lists all viewers who are invited" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        movie = MovieFacade.get_first_movie('dune')
        viewer_1 = create(:user, name: 'Abby')
        viewer_2 = create(:user, name: 'Bob')
        viewer_3 = create(:user, name: 'Charlie')
        viewers = [viewer_1, viewer_2, viewer_3]
        party = create(:party_with_viewers, host: user_1, viewers: viewers, movie_id: movie.id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

        visit user_path(user_1)

        within "div.movie_#{movie.id}_viewers" do
          expect(page).to have_content("Abby")
          expect(page).to have_content("Bob")
          expect(page).to have_content("Charlie")
          expect(page).to_not have_content("Jeff")
        end
      end
    end

    it "lists all parties the user is involved with" do
      VCR.use_cassette('multiple_movies_1') do
        movie_1 = MovieFacade.get_first_movie('dune')
        VCR.use_cassette('multiple_movies_2') do
          movie_2 = MovieFacade.get_first_movie('terminator salvation')
          VCR.use_cassette('multiple_movies_3') do
            movie_3 = MovieFacade.get_first_movie('the matrix resurrections')
            user_2 = create(:user)
            user_3 = create(:user)
            user_4 = create(:user)

            party_1 = create(:party_with_viewers, host: user_1, viewer_count: 4, movie_id: movie_1.id, start_time: DateTime.new(2022, 02, 02, 12, 10, 0))
            party_2 = create(:party_with_viewers, host: user_2, viewers: [user_1, user_3, user_4], movie_id: movie_2.id, start_time: DateTime.new(2022, 02, 02, 14, 00, 0))
            party_3 = create(:party_with_viewers, host: user_3, viewers: [user_1, user_4], movie_id: movie_3.id, start_time: DateTime.new(2022, 02, 02, 18, 30, 0))

            visit user_path(user_1)

            within "div.viewing_party_#{movie_1.id}" do
              expect(page).to have_content("Hosting")
              expect(page).to have_content("Title: Dune")
            end

            within "div.viewing_party_#{movie_2.id}" do
              expect(page).to_not have_content("Hosting")
              expect(page).to have_content("Title: Terminator Salvation")
            end

            within "div.viewing_party_#{movie_3.id}" do
              expect(page).to_not have_content("Hosting")
              expect(page).to have_content("Title: The Matrix Resurrections")
            end
          end
        end
      end
    end
  end
end
