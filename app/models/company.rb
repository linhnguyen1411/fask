class Company < ApplicationRecord
  has_many :work_spaces
  has_many :categories

  validates :name, presence: true,
    length: {maximum: Settings.company.max_name, minimum: Settings.company.min_name}
end
