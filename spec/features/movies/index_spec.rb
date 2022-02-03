require 'rails_helper'

RSpec.describe 'user movie results page' do
  let!(:user) {User.create(name: "Jeff", email: "jeff@email.com")}
  let!(:top_rated_url) {"/users/#{user.id}/movies?q=top%20rated"}
  let!(:search_url) {"/users/#{user.id}/movies?q=dune"}

  it 'shows app name when viewing top rated' do
    VCR.use_cassette('user_top_rated_movies') do
      visit top_rated_url

      expect(page).to have_content("Viewing Party")
    end
  end

  it 'shows app name when viewing search results' do
    VCR.use_cassette('user_dune_search') do
      visit search_url

      expect(page).to have_content("Viewing Party")
    end
  end

  it 'links to homepage when viewing top rated' do
    VCR.use_cassette('user_top_rated_movies') do
      visit top_rated_url

      expect(page).to have_link("Home")
      click_link "Home"
      expect(current_path).to eq(root_path)
    end
  end

  it 'links to homepage when viewing search results' do
    VCR.use_cassette('user_dune_search') do
      visit search_url

      expect(page).to have_link("Home")
      click_link "Home"
      expect(current_path).to eq(root_path)
    end
  end

  it 'shows correct heading when viewing top rated' do
    VCR.use_cassette('user_top_rated_movies') do
      visit top_rated_url

      expect(page).to have_content("Top Rated Movies")
    end
  end

  it 'shows correct heading when viewing search results' do
    VCR.use_cassette('user_dune_search') do
      visit search_url

      expect(page).to have_content("Movie results for: dune")
    end
  end

  it 'links back to discover page when viewing top rated' do
    VCR.use_cassette('user_top_rated_movies') do
      visit top_rated_url

      expect(page).to have_link("Discover Page")
      click_link "Discover Page"
      expect(current_path).to eq("/users/#{user.id}/discover")
    end
  end

  it 'links back to discover page when viewing search results' do
    VCR.use_cassette('user_dune_search') do
      visit search_url

      expect(page).to have_link("Discover Page")
      click_link "Discover Page"
      expect(current_path).to eq("/users/#{user.id}/discover")
    end
  end

  it 'shows each movie title and vote average when viewing top rated' do
    VCR.use_cassette('user_top_rated_movies') do
      visit top_rated_url

      within("#movie-id-730154") do
        expect(page).to have_content("Title: Your Eyes Tell")
        expect(page).to have_content("Vote average: 8.8")
      end

      within("#movie-id-19404") do
        expect(page).to have_content("Title: Dilwale Dulhania Le Jayenge")
        expect(page).to have_content("Vote average: 8.7")
      end

      within("#movie-id-278") do
        expect(page).to have_content("Title: The Shawshank Redemption")
        expect(page).to have_content("Vote average: 8.7")
      end
    end
  end

  it 'shows each movie title and vote average when viewing search results' do
    VCR.use_cassette('user_dune_search') do
      visit search_url

      within("#movie-id-438631") do
        expect(page).to have_content("Title: Dune")
        expect(page).to have_content("Vote average: 7.9")
      end

      within("#movie-id-841") do
        expect(page).to have_content("Title: Dune")
        expect(page).to have_content("Vote average: 6.3")
      end

      within("#movie-id-191720") do
        expect(page).to have_content("Title: Jodorowsky's Dune")
        expect(page).to have_content("Vote average: 7.9")
      end
    end
  end

end
