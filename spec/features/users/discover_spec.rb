require 'rails_helper'

RSpec.describe 'the user discover page' do

  it "has a form to search by movie title that redirects you to a results page" do
    visit "/discover"

    VCR.use_cassette('Fight_Club_search') do
      fill_in :q, with: 'Fight Club'
      click_button 'Search'

      expect(current_path).to eq("/movies")
    end
  end

  it "has a button to search for top rated movies that redirects you to a results page" do
    visit "/discover"

    VCR.use_cassette('top_rated_search') do
      click_button 'Discover Top Rated Movies'

      expect(current_path).to eq("/movies")
    end
  end
end
