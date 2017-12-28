class Category < ApplicationRecord
  belongs_to :parent_category, class_name: Category.name, foreign_key: :parent_id,
    optional: true
  has_many :children_categories, class_name: Category.name, foreign_key: :parent_id, dependent: :destroy
  has_many :posts
  validates :name, presence: true,
    length: {maximum: Settings.category.max_name, minimum: Settings.category.min_name}

  acts_as_paranoid

  scope :include_count_post, ->  do
    joins("LEFT JOIN posts ON posts.category_id = categories.id")
      .group("categories.id").select("categories.*, count(posts.id) as count_post")
  end
end
