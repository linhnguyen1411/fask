require "rails_helper"

RSpec.describe Post, type: :model do

  context "association" do
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :answers}
    it{is_expected.to have_many :reactions}
    it{is_expected.to have_many :clips}
    it{is_expected.to have_and_belong_to_many :tags}

    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :work_space}
    it{is_expected.to belong_to :topic}
  end
end
