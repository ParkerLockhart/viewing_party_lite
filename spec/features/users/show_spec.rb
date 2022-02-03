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
        facade = MovieFacade.new
        movie_id = facade.movie_results('dune')[0].movie_id
        movie = facade.movie_info(movie_id)
        party = create(:party, host: user_1, movie_id: movie_id)

        visit user_path(user_1)

        expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg']")
      end
    end

    it "has a title that links to the movie show page" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        facade = MovieFacade.new
        movie_id = facade.movie_results('dune')[0].movie_id
        movie = facade.movie_info(movie_id)
        party = create(:party, host: user_1, movie_id: movie_id)

        visit user_path(user_1)

        click_link "Title: Dune"
        expect(current_path).to eq("/users/#{user_1.id}/movies/#{movie_id}")
      end
    end

    it "has date and time of event" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        facade = MovieFacade.new
        movie_id = facade.movie_results('dune')[0].movie_id
        movie = facade.movie_info(movie_id)
        party = create(:party, host: user_1, movie_id: movie_id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

        visit user_path(user_1)

        expect(page).to have_content("Date: Feb 2, 2022")
        expect(page).to have_content("Time: 6:10 PM")
      end
    end

    it "lists the host" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        facade = MovieFacade.new
        movie_id = facade.movie_results('dune')[0].movie_id
        movie = facade.movie_info(movie_id)
        party = create(:party_with_viewers, host: user_1, viewer_count: 4, movie_id: movie_id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

        visit user_path(user_1)

        expect(page).to have_content("Host: Jeff")
      end
    end

    it "lists all viewers who are invited" do
      VCR.use_cassette('create_movie_from_search_dune2') do
        facade = MovieFacade.new
        movie_id = facade.movie_results('dune')[0].movie_id
        movie = facade.movie_info(movie_id)
        viewer_1 = create(:user, name: 'Abby')
        viewer_2 = create(:user, name: 'Bob')
        viewer_3 = create(:user, name: 'Charlie')
        viewers = [viewer_1, viewer_2, viewer_3]
        party = create(:party_with_viewers, host: user_1, viewers: viewers, movie_id: movie_id, start_time: DateTime.new(2022, 02, 02, 18, 10, 0))

        visit user_path(user_1)

        within "div.movie_#{movie_id}_viewers" do
          expect(page).to have_content("Abby")
          expect(page).to have_content("Bob")
          expect(page).to have_content("Charlie")
          expect(page).to_not have_content("Jeff")
        end
      end
    end
  end
end
