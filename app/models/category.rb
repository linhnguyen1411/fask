class Category < ApplicationRecord
  belongs_to :company
  belongs_to :parent_category, class_name: Category.name, foreign_key: :parent_id,
    optional: true
  has_many :children_categories, class_name: Category.name, foreign_key: :parent_id, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.category.max_name, minimum: Settings.category.min_name}

  acts_as_paranoid
end
