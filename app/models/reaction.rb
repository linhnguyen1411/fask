class Reaction < ApplicationRecord
  include PublicActivity::Model
  tracked only:[:create], owner: ->(controller, model){controller && controller.current_user}

  belongs_to :user
  belongs_to :reactiontable, polymorphic: true

  enum target_type: {upvote: 0, downvote: 1, like: 2, dislike: 3, heart: 4}
end
