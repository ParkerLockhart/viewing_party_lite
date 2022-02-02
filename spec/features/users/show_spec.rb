require 'rails_helper'

RSpec.describe 'user dashboard' do
  let!(:user_1) {User.create(name: "Jeff", email: "jeff@email.com")}
  let!(:user_2) {User.create(name: "Amy", email: "amy@email.com")}

  before(:each) do
    visit user_path(user_1)
  end

  it 'shows page title with user name' do
    expect(page).to have_content("Jeff's Dashboard")
  end

  it 'has a button to discover movies' do
    expect(page).to have_link("Discover Movies")
  end

  it 'has a section for viewing parties' do
    expect(page).to have_content("Viewing Parties")
  end
end
