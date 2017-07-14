class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactiontable, polymorphic: true
end
