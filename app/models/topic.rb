class Topic < ApplicationRecord
  acts_as_paranoid

  has_many :posts, dependent: :destroy
  has_many :topices_users, dependent: :destroy
  has_many :users, through: :topices_users
end
