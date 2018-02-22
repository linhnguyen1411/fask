class Topic < ApplicationRecord
  acts_as_paranoid

  has_many :posts, dependent: :destroy
  has_many :topices_users, dependent: :destroy
  has_many :users, through: :topices_users

  scope :load_topic_not_confession, -> { where.not id: Settings.topic.confesstion_number }
  scope :load_feedback_topic, -> { where id: Settings.topic.feedback_number }
  scope :load_topic_on, -> { where status: 1 }
end
