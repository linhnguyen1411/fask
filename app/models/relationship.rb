class Relationship < ApplicationRecord
  include PublicActivity::Model
  tracked owner: ->(controller, model){controller && controller.current_user}

  belongs_to :follower, class_name: User.name
  belongs_to :following, class_name: User.name
end
