class Relationship < ApplicationRecord
  include PublicActivity::Model
  tracked only:[:create, :destroy],
    owner: ->(controller, model){controller && controller.current_user},
    recipient: ->(controller, model) {model && model.following }

  belongs_to :follower, class_name: User.name
  belongs_to :following, class_name: User.name

  has_many :activities, as: :trackable,
    class_name: "PublicActivity::Activity"
end
