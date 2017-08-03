class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked

  acts_as_paranoid

  belongs_to :user
  belongs_to :post
  belongs_to :answer
end
