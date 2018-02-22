class Tag < ApplicationRecord
  acts_as_paranoid
  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags

  scope :by_used_count, ->{order(used_count: :desc).limit Settings.max_search_tags}

  scope :top_tags, -> do
    joins(:posts_tags).includes(posts: :topic).where(topics: {status: true}).group("posts_tags.tag_id").
      order "count(posts_tags.post_id) DESC"
  end
end
