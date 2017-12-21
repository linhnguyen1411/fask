require "rails_helper"

RSpec.describe Supports::PostSupport, type: :model do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end

  subject {Supports::PostSupport.new Post, topic.id, "newest", true, 1}

  describe "#recent_posts" do
    it {expect(subject.recent_posts[:posts]).to eq [post]}
  end

  describe "#popular_posts" do
    it {expect(subject.popular_posts[:posts]).to eq [post]}
  end

  describe "#posts_no_answer" do
    it "post no answer" do
      expect(subject.posts_no_answer[:posts]).to eq [post]
    end

    it "post have answer" do
      FactoryGirl.create :answer, user: user, post: post

      expect(subject.posts_no_answer[:posts]).to eq []
    end
  end

  describe "#recently_answer_of_post" do
    it "post no answer" do
      expect(subject.recently_answer_of_post[:posts]).to eq []
    end

    it "post have answer" do
      FactoryGirl.create :answer, user: user, post: post

      expect(subject.recently_answer_of_post[:posts]).to eq [post]
    end
  end

  describe "#recent_comment_of_post" do
    it "post no comment" do
      expect(subject.recent_comment_of_post).to eq []
    end

    it "post have comment" do
      FactoryGirl.create :comment, user_id: user.id, commentable_id: post.id,
        commentable_type: "Post"

      expect(subject.recent_comment_of_post).to eq [post]
    end
  end

  describe "#hot_post" do
    it {expect(subject.hot_post).to eq [post]}
  end
end
