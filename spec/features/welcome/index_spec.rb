require 'rails_helper'

RSpec.describe 'landing page' do
  let!(:user_1) {User.create(name: "Jeff", email: "jeff@email.com")}
  let!(:user_2) {User.create(name: "Amy", email: "amy@email.com")}

  before(:each) do
    visit root_path
  end

  it 'shows the title of the app' do
    expect(page).to have_content("Viewing Party")
  end

  it 'shows a button to create new user' do
    click_link "Create New User"
    expect(current_path).to eq("/register")
  end

  it 'links to existing user dashboards' do
    expect(page).to have_link("jeff@email.com")
    expect(page).to have_link("amy@email.com")
    click_link "jeff@email.com"
    expect(current_path).to eq("/users/#{user_1.id}")
  end

  it 'links back to landing page' do
    expect(page).to have_link("Home")
    click_link "Home"
    expect(current_path).to eq(root_path)
  end
end
