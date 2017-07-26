class Company < ApplicationRecord
  has_many :users, foreign_key: :company_id
  has_many :work_spaces

  belongs_to :owner, class_name: User.name

end
