require 'rails_helper'

RSpec.describe 'movie details page' do
  let!(:user) {create(:user, name: 'Jeff')}
  let!(:dune_url) {"/users/#{user.id}/movies/438631"}

  before(:each) do
    VCR.insert_cassette('dune_details')
    VCR.insert_cassette('dune_reviews')
    VCR.insert_cassette('dune_new_party')
    visit dune_url
  end

  after(:each) do
    VCR.eject_cassette('dune_details')
    VCR.eject_cassette('dune_reviews')
    VCR.eject_cassette('dune_new_party')
  end

  it 'shows app name' do
    expect(page).to have_content("Viewing Party")
  end

  it 'links to homepage' do
    expect(page).to have_link("Home")
    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it 'links back to discover page' do
    expect(page).to have_link("Discover Page")
    click_link "Discover Page"
    expect(current_path).to eq("/users/#{user.id}/discover")
  end

  it 'links to viewing-party/new' do
    expect(page).to have_link("Create Viewing Party for Dune")
    click_link "Create Viewing Party for Dune"
    expect(current_path).to eq("/users/#{user.id}/movies/438631/viewing-party/new")
  end

  it 'shows movie title' do
    expect(page).to have_content("Dune")
  end

  it 'shows movie vote_average' do
    expect(page).to have_content("Vote Average: 7.9")
  end

  it 'shows movie runtime' do
    expect(page).to have_content("Runtime: 2hr 35 min")
  end

  it 'shows movie genres' do
    expect(page).to have_content("Genre(s): Science Fiction, Adventure")
  end

  it 'shows movie summary' do
    expect(page).to have_content("Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.")
  end

  it 'shows movie cast(max 10)' do
    expect(page).to have_content("Timothée Chalamet as Paul Atreides")
    expect(page).to have_content("Rebecca Ferguson as Lady Jessica Atreides")
    expect(page).to have_content("Oscar Isaac as Duke Leto Atreides")
    expect(page).to have_content("Josh Brolin as Gurney Halleck")
    expect(page).to have_content("Stellan Skarsgård as Baron Vladimir Harkonnen")
    expect(page).to have_content("Dave Bautista as Beast Rabban Harkonnen")
    expect(page).to have_content("Sharon Duncan-Brewster as Dr. Liet Kynes")
    expect(page).to have_content("Stephen McKinley Henderson as Thufir Hawat")
    expect(page).to have_content("Zendaya as Chani")
    expect(page).to have_content("Chang Chen as Dr. Wellington Yueh")
  end

  it 'shows movie reviews with author' do
    expect(page).to have_content("Author: Habenula")
    expect(page).to have_content("The worst movie I've ever seen. Don't waste your time.")
  end
end
