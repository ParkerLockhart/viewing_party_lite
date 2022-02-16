class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users
  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true

  has_secure_password

  def host_parties
    parties.where(party_users: { host: true })
  end

  def viewer_parties
    parties.where(party_users: { host: false })
  end

  def self.not_host(user_id)
    User.where.not(id: user_id)
  end
end
