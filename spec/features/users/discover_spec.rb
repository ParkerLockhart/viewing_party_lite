require 'rails_helper'

RSpec.describe 'the user discover page' do
  let!(:user) {User.create!(name: 'Bob', email: 'bob@email.com')}


  it "has a form to search by movie title that redirects you to a results page" do
    visit "/users/#{user.id}/discover"

    VCR.use_cassette('Fight_Club_search') do
      fill_in :q, with: 'Fight Club'
      click_button 'Search'

      expect(current_path).to eq("/users/#{user.id}/movies?q=Fight%20Club")
    end
  end
end
