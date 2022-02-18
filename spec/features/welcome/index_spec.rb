require 'rails_helper'

RSpec.describe 'landing page' do
  let!(:user_1) {create(:user, name: "Jeff")}
  let!(:user_2) {create(:user, name: "Amy")}

  before(:each) do
    visit root_path
  end

  it 'shows the title of the app' do
    expect(page).to have_content("Viewing Party")
  end

  it 'only shows a link to create new user when not logged in' do
    click_link "Register New User"
    expect(current_path).to eq("/register")
    click_link "Log In"
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")
    visit root_path
    expect(page).to_not have_content("Register New User")
  end

  it 'only shows a link to login when not logged in' do
    click_link "Log In"
    expect(current_path).to eq('/login')
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")
    visit root_path
    expect(page).to_not have_content("Log In")
  end

  it 'doesnt show login link when logged in' do
    visit '/login'
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")
    visit root_path
    expect(page).to_not have_content("Log In")
  end

  it 'only shows logout link when logged in' do
    visit '/login'
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")
    expect(page).to have_content("Log Out")
    click_link "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Logout successful.")
    expect(page).to have_link("Register New User")
    expect(page).to have_link("Log In")
  end

  it 'shows existing user emails' do
    expect(page).to have_content("jeff@email.com")
    expect(page).to have_content("amy@email.com")
  end

  it 'links back to landing page' do
    expect(page).to have_link("Home")
    click_link "Home"
    expect(current_path).to eq(root_path)
  end
end
