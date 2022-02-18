require 'rails_helper'

RSpec.describe 'new user page' do
  before(:each) do
    visit "/register"
  end

  it 'shows the title of the app' do
    expect(page).to have_content("Viewing Party")
  end

  it 'links back to landing page' do
    expect(page).to have_link("Home")
    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it 'can create new user' do
    fill_in 'user[name]', with: "Megan"
    fill_in 'user[email]', with: "megan@email.com"
    fill_in 'user[password]', with: "password123"
    fill_in 'user[password_confirmation]', with: "password123"
    click_button("Create New User")
    user = User.last

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("#{user.name}'s Dashboard")
  end

  it 'will not create user if password confirmation fails' do
    fill_in 'user[name]', with: "Megan"
    fill_in 'user[email]', with: "megan@email.com"
    fill_in 'user[password]', with: "password123"
    fill_in 'user[password_confirmation]', with: "password124"
    click_button("Create New User")
    user = User.last

    expect(current_path).to eq("/register")
    expect(page).to have_content("Error: Passwords don't match")
  end

  it 'will not create user without name and shows custom error' do

    fill_in 'user[email]', with: "megan@email.com"
    fill_in 'user[password]', with: "password123"
    fill_in 'user[password_confirmation]', with: "password123"
    click_button("Create New User")

    expect(current_path).to eq("/register")
    expect(page).to have_content("Error: Name can't be blank")
  end

  it 'will not create user without email and shows custom error' do
    fill_in 'user[name]', with: "Megan"
    fill_in 'user[password]', with: "password123"
    fill_in 'user[password_confirmation]', with: "password123"
    click_button("Create New User")

    expect(current_path).to eq("/register")
    expect(page).to have_content("Error: Email can't be blank")
  end
end
