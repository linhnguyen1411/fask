require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) {FactoryGirl.create :user}
  let!(:user_a) {FactoryGirl.create :user}
  let(:work_space) {FactoryGirl.create :work_space}
  let(:topic) {FactoryGirl.create :topic}
  let!(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end

  context "association" do
    it{is_expected.to have_many :posts}
    it{is_expected.to have_many :clips}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :reactions}
    it{is_expected.to have_many :answers}
    it{is_expected.to have_many :notifications}
    it{is_expected.to have_many :topices_users}
    it{is_expected.to have_many :users_work_spaces}
    it{is_expected.to have_many :active_relationships}
    it{is_expected.to have_many :passive_relationships}
    it{is_expected.to have_many :following}
    it{is_expected.to have_many :followers}
    it{is_expected.to have_many :work_spaces}
    it{is_expected.to have_many :topics}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
  end

  context ".top_users" do
    it "dont't have user" do
      expect(User.top_users.length).to be 0
    end

    it "have users" do
      FactoryGirl.create :answer, user: user, post: post
      expect(User.top_users.length).to be 1
    end
  end

  context ".get_activities" do
    it "have activities" do
      expect(User.get_activities(user).count).to be 1
    end

    it "not exist activities" do
      user.id = nil
      expect(User.get_activities(user).count).to be 0
    end
  end

  context ".get_users_not_contain_id" do
    it do
      expect(User.get_users_not_contain_id(user).length).to eq 1
    end
  end

  context ".follow" do
    it do
      User.follow(user, user_a.id)
      expect(User.check_follow(user, user_a)).to eq 1
    end
  end

  context ".unfollow" do
    it do
      User.follow(user, user_a.id)
      User.unfollow(user, user_a.id)
      expect(User.check_follow(user, user_a)).to eq 0
    end
  end

  context ".check_follow" do
    it do
      User.follow(user, user_a.id)
      expect(User.check_follow(user, user_a)).to eq 1
      User.unfollow(user, user_a.id)
      expect(User.check_follow(user, user_a)).to eq 0
    end
  end
end
