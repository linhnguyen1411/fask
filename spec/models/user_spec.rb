require "rails_helper"

RSpec.describe User, type: :model do
  let(:work_space) {FactoryGirl.create :work_space}
  let(:user) {FactoryGirl.create :user}
  let(:topic) {FactoryGirl.create :topic}
  let!(:post) {FactoryGirl.create :post, work_space: work_space, user: user,
    topic: topic}

  context "association" do
    it{expect have_many :posts}
    it{is_expected.to have_many :clips}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :reactions}
    it{is_expected.to have_many :answers}

    it{expect have_and_belong_to_many :work_spaces}
    it{expect have_and_belong_to_many :topics}

    context "validates" do
      it {is_expected.to validate_presence_of :name}
    end

    describe "#get_activities" do
      context "get activities with user signed in" do
        it "have activities" do
          user.id = nil
          expect(User.get_activities(user).count).to be 1
        end

        it "not exist activities" do
          expect(User.get_activities(user).count).to be 0
        end
      end
    end

    describe "#top_users" do
      it "dont't have user" do
        expect(User.top_users.length).to be 0
      end

      it "have users" do
        FactoryGirl.create :answer, user: user, post: post
        expect(User.top_users.length).to be 1
      end
    end
  end
end
