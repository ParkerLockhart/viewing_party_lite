require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end

  describe 'secure user creation' do
    it 'saves user auth information securely' do
      user = User.create(name: "Jeff", email: "jeff@email.com", password: "password123", password_confirmation: "password123")
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq("password123")
    end
  end

  describe 'instance methods' do
    describe '#host_parties' do
      it "returns all the viewing parties that the user is hosting" do
        user = User.create(name: "Jeff", email: "jeff@email.com", password: "password123", password_confirmation: "password123")
        party_1 = create(:party_with_viewers, host: user, viewer_count: 3)
        party_2 = create(:party_with_viewers, host: user, viewer_count: 5)
        party_3 = create(:party_with_viewers, viewer_count: 4)

        expect(user.host_parties).to eq([party_1, party_2])
      end
    end

    describe '#viewer_parties' do
      it "returns all the viewing parties that the user is viewing but not hosting" do
        user_1 = User.create(name: "Jeff", email: "jeff@email.com", password: "password123", password_confirmation: "password123")
        user_2 = User.create(name: "Amy", email: "amy@email.com", password: "password123", password_confirmation: "password123")
        user_3 = User.create(name: "Megan", email: "megan@email.com", password: "password123", password_confirmation: "password123")

        party_1 = create(:party_with_viewers, host: user_1, viewer_count: 3)
        party_2 = create(:party_with_viewers, viewers: [user_1, user_3])
        party_3 = create(:party_with_viewers, viewers: [user_1, user_2, user_3])
        party_4 = create(:party_with_viewers, viewers: [user_2, user_3])

        expect(user_1.viewer_parties).to eq([party_2, party_3])
      end
    end
  end

  describe 'class methods' do
    describe '.not_hosts' do
      it "returns all the users but the passed user_id" do
        user_1 = User.create(name: "Abby", email: "abby@email.com", password: "password123", password_confirmation: "password123")
        user_2 = User.create(name: "Bob", email: "bob@email.com", password: "password123", password_confirmation: "password123")
        user_3 = User.create(name: "Christy", email: "christy@email.com", password: "password123", password_confirmation: "password123")
        user_4 = User.create(name: "Dave", email: "dave@email.com", password: "password123", password_confirmation: "password123")

        expect(User.not_host(user_2.id)).to eq([user_1, user_3, user_4])
      end
    end
  end
end
