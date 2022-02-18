require 'rails_helper'

RSpec.describe 'new viewing party page' do
  let!(:user) {create(:user, name: "Jeff")}

  before(:each) do
    visit '/login'
    fill_in 'email', with: "jeff@email.com"
    fill_in 'password', with: "password123"
    click_button("Log In")
  end

  it "exists" do
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_content("Dune")
    end
  end

  it "has a form with a duration of party field that has a default value set to the movie length" do
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_field('Duration of Party', with: 155)
      fill_in 'Duration of Party', with: "300"
    end
  end

  it "has a form with a date and time field" do
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      fill_in 'Start Time', with: "02/03/2022 06:30"
      expect(page).to have_field('Start Time', with: "02/03/2022 06:30")
    end
  end

  it "has checkboxes for each user in the system" do
    user_1 = create(:user, name: 'Abby')
    user_2 = create(:user, name: 'Bob')
    user_3 = create(:user, name: 'Christy')
    user_4 = create(:user, name: 'Dave')

    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      within 'div.viewers' do
        expect(page).to have_content('Abby')
        expect(page).to have_content('Bob')
        expect(page).to have_content('Christy')
        expect(page).to have_content('Dave')
        expect(page).to_not have_content('Jeff')
      end
    end
  end

  it "has a submit button that creates a new viewing party and party_user objects and redirects to user dashboard" do
    user_1 = create(:user, name: 'Abby')
    user_2 = create(:user, name: 'Bob')
    user_3 = create(:user, name: 'Christy')
    user_4 = create(:user, name: 'Dave')

    VCR.use_cassette('create_new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      fill_in 'Duration of Party', with: "300"
      fill_in 'Start Time', with: "02/03/2022 06:30"

      within 'div.viewers' do
        check 'Abby'
        check 'Bob'
        check 'Dave'
      end

      click_button "Create Viewing Party"

      party = Party.last
      party_users = PartyUser.last(4)
      party_user_host = party_users[0]
      party_user_1 = party_users[1]
      party_user_2 = party_users[2]
      party_user_4 = party_users[3]

      expect(party.movie_id).to eq(movie.id)
      expect(party.duration).to eq(300)
      expect(party.start_time).to eq('2022-03-02 06:30:00.000000000 +0000')

      expect(party_user_host.party_id).to eq(party.id)
      expect(party_user_host.user_id).to eq(user.id)
      expect(party_user_host.host).to eq(true)

      expect(party_user_1.party_id).to eq(party.id)
      expect(party_user_1.user_id).to eq(user_1.id)
      expect(party_user_1.host).to eq(false)

      expect(party_user_2.party_id).to eq(party.id)
      expect(party_user_2.user_id).to eq(user_2.id)
      expect(party_user_2.host).to eq(false)

      expect(party_user_4.party_id).to eq(party.id)
      expect(party_user_4.user_id).to eq(user_4.id)
      expect(party_user_4.host).to eq(false)

      expect(current_path).to eq("/dashboard")
    end
  end

  it "doesn't allow parties of duration shorter than the movie duration" do
    VCR.use_cassette('bad_viewing_party_duration_dune') do
      user_1 = create(:user, name: 'Abby')
      user_2 = create(:user, name: 'Bob')
      user_3 = create(:user, name: 'Christy')
      user_4 = create(:user, name: 'Dave')

      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      fill_in 'Duration of Party', with: "100"
      fill_in 'Start Time', with: "02/06/2026 06:30"

      within 'div.viewers' do
        check 'Abby'
        check 'Bob'
        check 'Dave'
      end

      click_button 'Create Viewing Party'

      expect(current_path).to eq("/movies/#{movie.id}/viewing-party/new")
      expect(page).to have_content("Error: please enter a duration that is longer than the movie run time.")
    end
  end

  it 'only allows access to logged in users' do
    click_link "Log Out"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Logout successful.")
    VCR.use_cassette('new_viewing_party_dune') do
      movie = MovieFacade.get_first_movie('dune')
      visit "/movies/#{movie.id}/viewing-party/new"

      expect(page).to have_content("You must be logged in to access this page.")
      expect(current_path).to eq(root_path)
    end
  end

end
