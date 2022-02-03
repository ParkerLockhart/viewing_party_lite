require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'instance methods' do
    describe '#host_parties' do
      it "returns all the viewing parties that the user is hosting" do
        user = create(:user)
        party_1 = create(:party_with_viewers, host: user, viewer_count = 3)
        party_2 = create(:party_with_viewers, host: user, viewer_count = 5)
        party_3 = create(:party_with_viewers, viewer_count = 4)

        expect(user.host_parties).to eq([party_1, party_2])
      end
    end

    describe '#viewer_parties' do
      it "returns all the viewing parties that the user is viewing but not hosting" do
        user_1 = create(:user)
        user_2 = create(:user)
        user_3 = create(:user)

        party_1 = create(:party_with_viewers, host: user, viewer_count = 3)
        party_2 = create(:party_with_viewers, viewers: [user_1, user_3])
        party_3 = create(:party_with_viewers, viewers: [user_1, user_2, user_3])
        party_4 = create(:party_with_viewers, viewers: [user_2, user_3])

        expect(user_1.viewer_parties).to eq([party_2, party_3])
      end
    end
  end
end
