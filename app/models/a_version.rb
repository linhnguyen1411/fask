class AVersion < ApplicationRecord
	has_many :activities, as: :trackable, dependent: :destroy

	belongs_to :user
	belongs_to :a_versionable, polymorphic: true, optional: true

	enum status: {waiting: 0, accept: 1, reject: 2, improve: 3}
	after_create :create_activity

	scope :get_version, -> id,type {where a_versionable_id: id,
		a_versionable_type: type}
	scope :get_version_not_reject, -> { where.not status: 2 }
	scope :get_version_accept, ->{where status: 1}
  private 

  def create_activity
    self.activities.create owner: self.user
  end
end
