class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users
end
