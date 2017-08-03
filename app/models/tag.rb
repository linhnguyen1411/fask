class Tag < ApplicationRecord
  acts_as_paranoid
  has_many :posts_tag, dependent: :destroy
  has_many :posts, through: :posts_tag
end
