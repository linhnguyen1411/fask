class Clip < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :activities, as: :trackable, dependent: :destroy
  after_create :create_activity
  private

  def create_activity
    self.activities.create owner: self.user
  end
end
