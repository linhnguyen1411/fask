class Answer < ApplicationRecord

  acts_as_paranoid

  STANDARDIZE_REGEX = /<a class=\"tag-user-item\" href=\"\/users\/\d{1,}\"><i class=\"fa fa-address-book-o\"><\/i><\/a>|<a href=\"\/users\/\d{1,}\" class=\"tag-user-item\"><\/a>/
  delegate :name, to: :user, prefix: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :reactiontable, dependent: :destroy
  has_many :activities, as: :trackable, dependent: :destroy
  has_many :improves, as: :improvable, dependent: :destroy

  belongs_to :post
  belongs_to :user

  after_create :create_activity
  before_save :standardize_content

  private

  def create_activity
    self.activities.create owner: self.user
  end

  def standardize_content
    content.remove! "<p><br></p>"
    content.remove! STANDARDIZE_REGEX
  end
end
