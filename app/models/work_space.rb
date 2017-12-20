class WorkSpace < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :users
  belongs_to :company

  scope :get_work_space, -> id{where id: id}
end
