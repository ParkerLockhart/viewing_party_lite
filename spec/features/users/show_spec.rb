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
      VCR.use_cassette('create_movie_from_search_dune') do
        facade = MovieFacade.new
        movie_id = facade.movie_result('dune')[0].id
        movie = facace.movie_info(movie_id)
        party = create(:party, host: user_1, movie_id: movie_id)

        visit user_path(user_1)

        expect(page).to have_css("img[src=https://image.tmdb.org/t/p/original/d5NXSklXo0qyIYkgV94XAgMIckC.jpg]")
      end
    end

    it "has a title that links to the movie show page" do
      VCR.use_cassette('create_movie_from_search_dune') do
        facade = MovieFacade.new
        movie_id = facade.movie_result('dune')[0].id
        movie = facace.movie_info(movie_id)
        party = create(:party, host: user_1, movie_id: movie_id)

        visit user_path(user_1)

        click_link "Dune"
        expect(current_path).to eq("/users/#{user_1.id}/movies/#{movie_id}")
      end
    end
  end
end
