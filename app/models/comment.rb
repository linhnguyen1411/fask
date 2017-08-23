class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model){controller && controller.current_user}

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
