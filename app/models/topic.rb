class Topic < ApplicationRecord
  has_many :topic_managers, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :users, through: :topic_managers
end
