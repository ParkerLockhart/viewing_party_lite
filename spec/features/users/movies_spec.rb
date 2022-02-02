require 'rails_helper'

RSpec.describe 'user movie results page' do
  let!(:user) {User.create(name: "Jeff", email: "jeff@email.com")}
  let!(:top_rated_url) {"/users/#{user.id}/movies?q=top%20rated"}

  scenario 'user top rated movies', :vcr do
    visit top_rated_url

    within("#movie-id-730154") do
      expect(page).to have_content("Title: Your Eyes Tell")
      expect(page).to have_content("Vote average: 8.8")
    end

    expect(page).to have_link("Discover Page")
    click_link "Discover Page"
    expect(current_path).to eq("/users/#{user.id}/discover")
  end

end
