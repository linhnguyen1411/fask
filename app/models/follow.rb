class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followtable, polymorphic: true
end
