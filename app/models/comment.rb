class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked

  belongs_to :user
  belongs_to :post
  belongs_to :answer
end
