require "rails_helper"

RSpec.describe Supports::TopicSupport, type: :model do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:topic) {FactoryGirl.create :feedback_topic}
  let(:categories) {FactoryGirl.create_list :category, 5}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let!(:posts) do
    FactoryGirl.create_list :post, 5, work_space: work_space, user: user,
    topic: topic, category_id: categories.first.id
  end
  let(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user,
    topic: topic, category_id: categories.first.id, status: :waiting
  end
  let(:answer) { FactoryGirl.create :answer, user_id: user.id, post_id: post.id}


  # let(:post) do
  #   FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  # end


  # let!(:comment_before_time) do
  #   FactoryGirl.create :comment, user_id: user.id,
  #   commentable_id: post.id, commentable_type: post.class
  # end
  # let!(:view_more_time) {Time.now}
  # let!(:comment_after_time) do
  #   FactoryGirl.create :comment, user_id: user.id, created_at: Date.tomorrow,
  #   commentable_id: post.id, commentable_type: post.class
  # end
  # let(:comments) do
  #   FactoryGirl.create_list :comment, 5, user_id: user.id,
  #   commentable_id: post.id, commentable_type: post.class
  # end
  # let!(:clip) {FactoryGirl.create :clip, user_id: user.id, post_id: post.id}
  # let(:tag) {FactoryGirl.create :tag}
  # let!(:post_tag) {FactoryGirl.create :posts_tag, post_id: post.id, tag_id: tag.id}
  # let!(:categoryies) {FactoryGirl.create_list :category, 5}
  # let!(:a_version) do
  #   FactoryGirl.create :a_version, user_id: user.id, status: :accept,
  #    a_versionable_id: post.id, a_versionable_type: post.class
  # end

  let(:topic_params) do
    {
      from_day: Date.yesterday, to_day: Date.tomorrow, work_space_id: work_space.id,
      id: topic.id, sort_type: "popular", category_id: categories.first.id , page: 1
    }
  end

  subject {Supports::TopicSupport.new topic_params}

  describe "#filter_posts" do
    it do
      post
      expect(subject.filter_posts).to eq posts
    end
  end

  describe "#work_space" do
    it do
      expect(subject.work_space).to eq work_space
    end
  end

  describe "#filter_type" do
    let(:filter_type) do
      {from_day: Date.yesterday, to_day: Date.tomorrow, sort_type: "popular"}
    end
    it do
      expect(subject.filter_type).to eq filter_type
    end
  end

  describe "#top_users" do
    it do
      answer
      expect(subject.top_users).to eq [user]
    end
  end

  describe "#tag_list" do
    it do
      expect(subject.tag_list).to eq []
    end
  end

  describe "#category_list" do
    it do
      expect(subject.category_list).to eq Category.include_count_post
    end
  end

  describe "#work_space_list" do
    it do
      answer
      expect(subject.work_space_list).to eq [work_space]
    end
  end

  describe "#sort_type_list" do
    it do
      expect(subject.sort_type_list).to eq Settings.sort_type_list
    end
  end

  describe "#total_post" do
    it do
      post
      expect(subject.total_post).to eq posts.length
    end
  end
end
