class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked only:[:create],  owner: ->(controller, model){controller && controller.current_user}

  acts_as_paranoid

  delegate :name, to: :user, prefix: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable,
    class_name: "PublicActivity::Activity", dependent: :destroy
end
