class Topic < ApplicationRecord
  acts_as_paranoid

  has_many :posts, dependent: :destroy
  has_many :users, as: :topices_user
  has_many :topices_users, dependent: :destroy
end
