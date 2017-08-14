class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked

  acts_as_paranoid

  delegate :name, to: :user, prefix: true
  delegate :title, to: :post, prefix: true

  belongs_to :user
  belongs_to :post
  belongs_to :answer
end
