class WorkSpace < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :users

  scope :get_work_space, -> id{where id: id}
end
