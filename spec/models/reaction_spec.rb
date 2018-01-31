require "rails_helper"

RSpec.describe Reaction, type: :model do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user){FactoryGirl.create :user, work_space: work_space}
  let(:topic_qa){FactoryGirl.create :knowledge_topic}
  let!(:the_post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_qa
  end
  let(:reaction){Reaction.create target_type: "upvote", user_id: user.id, reactiontable: the_post}

  context "association" do
    it{is_expected.to belong_to :user}
  end

  context "#create_activity" do
    it {expect {reaction}.to change(Activity, :count).by 1}
  end
end
