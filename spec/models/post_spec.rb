require "rails_helper"

RSpec.describe Post, type: :model do
  let(:user){FactoryGirl.create :user}
  let(:topic){FactoryGirl.create :topic}

  context "association" do
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :answers}
    it{is_expected.to have_many :reactions}
    it{is_expected.to have_many :clips}
    it{expect have_and_belong_to_many :tags}

    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :work_space}
    it{is_expected.to belong_to :topic}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_presence_of :content}

    it do
      is_expected.to validate_length_of(:title)
        .is_at_most Settings.post.max_title
    end

    it do
      is_expected.to validate_length_of(:title)
        .is_at_least Settings.post.min_title
    end

    it "is valid with a valid title" do
      expect(FactoryGirl.build(:post, user_id: user.id, topic_id: topic.id,
        title: "a" * Settings.post.max_title)).to be_valid
    end

    it "is invalid with a long title" do
      expect(FactoryGirl.build(:post, user_id: user.id, topic_id: topic.id,
        title: "a" * (Settings.post.max_title + 1))).not_to be_valid
    end

    it "is invalid with a short title" do
      expect(FactoryGirl.build(:post, user_id: user.id, topic_id: topic.id,
        title: "a" * (Settings.post.min_title - 1))).not_to be_valid
    end

    it "is invalid with a nil title" do
      expect(FactoryGirl.build(:post, user_id: user.id, topic_id: topic.id,
        title: nil)).not_to be_valid
    end
  end
end
