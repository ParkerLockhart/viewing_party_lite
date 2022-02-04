class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def host_parties
    parties.where(party_users: { host: true })
  end

  def viewer_parties
    parties.where(party_users: { host: false })
  end
end
