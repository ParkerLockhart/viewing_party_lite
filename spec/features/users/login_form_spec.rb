require 'rails_helper'

RSpec.describe 'user login form page' do
  before(:each) do
    visit "/login"
    @user = create(:user, name: "Jeff")
  end

  it 'will redirect user to dashboard if authenticated' do
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content("#{@user.name}'s Dashboard")
  end

  it 'will not redirect user to dashboard if authentication fails' do
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password124"
    click_button("Log In")

    expect(current_path).to eq("/login")
    expect(page).to have_content("Error: Unable to authenticate user. Please try again.")
  end

  it 'will not redirect user if user not found' do
    fill_in 'email', with: "amy@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")

    expect(current_path).to eq("/login")
    expect(page).to have_content("Error: Unable to find user with that email. Please try again or register.")
  end 
end
