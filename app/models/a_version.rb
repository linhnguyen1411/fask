class AVersion < ApplicationRecord
  has_many :activities, as: :trackable, dependent: :destroy

  belongs_to :user
  belongs_to :a_versionable, polymorphic: true, optional: true

  enum status: {waiting: 0, accept: 1, reject: 2, improve: 3}
  after_create :create_activity
  after_update :update_activity

  scope :get_version, -> id, type {where a_versionable_id: id, a_versionable_type: type}
  scope :get_version_post_not_reject, -> id, type do
    where "a_versionable_id = ? AND a_versionable_type = ? AND status != ?",
      id, type, Settings.version_reject.to_i
  end
  scope :get_version_accept, ->{where status: 1}

  validates :content, presence: true

  delegate :name, :position, :avatar, to: :user, prefix: true

  def get_content
    read_attribute(:content).html_safe
  end

  private

  def create_activity
    self.activities.create owner: self.user
  end

  def update_activity
    self.activities.create owner: self.a_versionable.user if
      self.status != Settings.version.improve
  end
end
