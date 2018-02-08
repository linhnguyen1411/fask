require "rails_helper"

RSpec.describe Supports::PostSupport, type: :model do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic, category_id: categories.first.id
  end
  let!(:answer) { FactoryGirl.create :answer, user_id: user.id, post_id: post.id}
  let!(:comment_before_time) do
    FactoryGirl.create :comment, user_id: user.id,
    commentable_id: post.id, commentable_type: post.class
  end
  let!(:view_more_time) {Time.now}
  let!(:comment_after_time) do
    FactoryGirl.create :comment, user_id: user.id, created_at: Date.tomorrow,
    commentable_id: post.id, commentable_type: post.class
  end
  let(:comments) do
    FactoryGirl.create_list :comment, 5, user_id: user.id,
    commentable_id: post.id, commentable_type: post.class
  end
  let!(:clip) {FactoryGirl.create :clip, user_id: user.id, post_id: post.id}
  let(:tag) {FactoryGirl.create :tag}
  let!(:post_tag) {FactoryGirl.create :posts_tag, post_id: post.id, tag_id: tag.id}
  let!(:categories) {FactoryGirl.create_list :category, 5}
  let!(:a_version) do
    FactoryGirl.create :a_version, user_id: user.id, status: :accept,
     a_versionable_id: post.id, a_versionable_type: post.class
  end
  let(:related_post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic, category_id: categories.first.id
  end
  subject {Supports::PostSupport.new post, {comment_page: 1, view_more_time: view_more_time}}

  describe "#hot_post" do
    it {expect(subject.hot_post).to eq [post]}
  end

  describe "#answers_of_post" do
    it {expect(subject.answers_of_post).to eq [answer]}
  end

  describe "#view_more_time" do
    it {expect(subject.view_more_time).to eq view_more_time}
  end

  describe "#comments_of_post" do
    it {expect(subject.comments_of_post).to eq [comment_before_time]}
  end

  describe "#next_page" do
    let(:support) {Supports::PostSupport.new post, {view_more_time: view_more_time}}
    it "not view more"do
      expect(subject.next_page).to eq Settings.not_view_more
    end

    it "not view more with omment_page is nil and have paginate"do
      comments
      post.reload
      expect(support.next_page).to eq 2
    end

    it "not view more with comment_page is nil"do
      expect(support.next_page).to eq Settings.not_view_more
    end

    it "second page"do
      comments
      post.reload
      expect(subject.next_page).to eq Settings.second_page
    end
  end

  describe "#count_vote" do
    it {expect(subject.count_vote).to eq 0}
  end

  describe "#count_comment" do
    it {expect(subject.count_comment).to eq 2}
  end

  describe "#count_version" do
    it {expect(subject.count_version).to eq 1}
  end

  describe "#check_a_version_for_post" do
    it {expect(subject.check_a_version_for_post).to eq a_version}
  end

  describe "#clip_list" do
    it {expect(subject.clip_list).to eq [clip]}
  end

  describe "#tag_list" do
    it {expect(subject.tag_list.reload).to eq [tag]}
  end

  describe "#category_list" do
    it {expect(subject.category_list).to eq categories.to_a}
  end

  describe "#work_space_list" do
    it {expect(subject.work_space_list).to eq [work_space]}
  end

  describe "#topic_list" do
    it {expect(subject.topic_list).to eq [topic]}
  end

  describe "#related_question" do
    it {expect(subject.related_question).to eq [related_post]}
  end
end
