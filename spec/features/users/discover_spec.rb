require 'rails_helper'

RSpec.describe 'the user discover page' do
  let!(:user) {User.create!(name: 'Bob', email: 'bob@email.com')}

  it "has a form to search by movie title and it takes you to a results page that shows all the relevant movie titles and ratings" do
    visit "/users/#{user.id}/discover"

    VCR.use_cassette('Fight_Club_search') do
      fill_in :search, with: 'Fight Club'
      click_button 'Search'

      #expect(current_path).to eq("/users/#{user.id}/search")


      url = 'https://api.themoviedb.org/3/search/movie'
      response = Faraday.get(url + "?api_key=#{ENV['movie_api_key']}&query=Fight%20Club")
      data = JSON.parse(response.body, symbolize_name: true)
      results = data['results']
      within 'div.movie_0' do
        expect(page).to have_content("Title: Fight Club")
        expect(page).to have_content("Vote Average: 8.4")
      end
    end
  end
end
