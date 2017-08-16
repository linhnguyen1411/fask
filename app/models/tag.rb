class Tag < ApplicationRecord
  acts_as_paranoid
  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags

  scope :by_used_count, ->{order(used_count: :desc).limit Settings.max_search_tags}
end
