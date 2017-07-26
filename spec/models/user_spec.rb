require "rails_helper"

RSpec.describe User, type: :model do
 
  context "association" do
    it{is_expected.to have_many :posts}
    it{is_expected.to have_many :topics}
    it{is_expected.to have_many :clips}
    it{is_expected.to have_many :topic_managers}
    it{is_expected.to have_many :notifications}
    it{is_expected.to have_many :reactions}
    it{is_expected.to have_many :follows}
    it{is_expected.to have_many :answers}

    it{is_expected.to belong_to :role}
    it{is_expected.to belong_to :company}
  end
end
