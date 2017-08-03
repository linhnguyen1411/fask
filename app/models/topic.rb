class Topic < ApplicationRecord
  acts_as_paranoid

  has_many :posts, dependent: :destroy
  has_many :topics_users, dependent: :destroy
  has_many :users, through: :topics_user
end
