class WorkSpace < ApplicationRecord
  has_many :posts, dependent: :destroy

  belongs_to :company
end
