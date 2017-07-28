class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactiontable, polymorphic: true

  enum target: [upvote: 0, downvote: 1, like: 2, dislike: 3, heart: 4]
end
