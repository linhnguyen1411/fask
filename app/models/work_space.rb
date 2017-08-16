class WorkSpace < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :users_work_spaces, dependent: :destroy
  has_many :users, as: :users_work_space
end
