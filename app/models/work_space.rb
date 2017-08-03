class WorkSpace < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :users_work_spaces, dependent: :destroy
  has_many :users, through: :users_work_space
end
