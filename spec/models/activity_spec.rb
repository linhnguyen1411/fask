require "rails_helper"
RSpec.describe Activity, type: :model do
  let(:work_space) {FactoryGirl.create :work_space}
  let!(:feedback_topic){FactoryGirl.create :feedback_topic}
  let!(:knowledge_topic){FactoryGirl.create :knowledge_topic}

  let!(:user_post){FactoryGirl.create :user, work_space_id: work_space.id}
  let!(:user_answer){FactoryGirl.create :user, work_space_id: work_space.id}
  let!(:user_comment){FactoryGirl.create :user, work_space_id: work_space.id}
  let(:user){FactoryGirl.create :user, work_space_id: work_space.id}
  let!(:tagged_user){FactoryGirl.create :user, work_space_id: work_space.id}
  let!(:user_developer){FactoryGirl.create :user, work_space_id: work_space.id}
  let!(:user_hr_administrator){FactoryGirl.create :user, work_space_id: work_space.id, position: "Hr administrator"}
  let!(:user_recruiter){FactoryGirl.create :user, work_space_id: work_space.id, position: "Recruiter"}
  let!(:user_event_officer){FactoryGirl.create :user, work_space_id: work_space.id, position: "Event Officer"}

  let!(:new_post){FactoryGirl.create :post, user_id: user_post.id, topic_id: feedback_topic.id, work_space_id: work_space.id}
  let!(:new_answer){FactoryGirl.create :answer, user_id: user_answer.id, post: new_post}
  let!(:new_comment){FactoryGirl.create :comment, user_id: user_comment.id, commentable: new_post}

  describe "When create post and turn on notification setting" do
    context "Send notification when create post without tag user" do
      it "Only send noti for users are Hr administrator, Recruiter, Event Officer if is a feedback post" do
        post = FactoryGirl.create :post, user_id: user_post.id, topic_id: feedback_topic.id,
          work_space_id: work_space.id
        notified_users = User.get_users_not_contain_id(user_post.id).notify_feedback_for_position.to_a
        post.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to match_array notified_users
        end
      end

      it "send noti for all user if isn't a feedback post" do
        post = FactoryGirl.create :post, user_id: user_post.id, topic_id: knowledge_topic.id,
          work_space_id: work_space.id
        notified_users = User.get_users_not_contain_id(user_post.id).to_a
        post.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to match_array notified_users
        end
      end
    end

    context "Send notification when create post within tag user" do
      it "A Feedback post - only send noti for tagged users and user are Hr administrator,
        Recruiter, Event Officer" do
        url_taged_user = "href=\"\/users\/" + tagged_user.id.to_s
        post = FactoryGirl.create :post, user_id: user_post.id, topic_id: feedback_topic.id,
          work_space_id: work_space.id, content: url_taged_user
        notified_users = User.get_users_not_contain_id(user_post.id).notify_feedback_for_position.to_a << tagged_user
        post.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to match_array notified_users
        end
      end

      it "A Knowledge Q&A post - send noti for all user - tagged users be send one time" do
        url_taged_user = "href=\"\/users\/" + tagged_user.id.to_s
        post = FactoryGirl.create :post, user_id: user_post.id, topic_id: knowledge_topic.id,
          work_space_id: work_space.id, content: url_taged_user
        notified_users = User.get_users_not_contain_id(user_post.id)
        post.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to match_array notified_users
        end
      end

      it "tagged users not exist" do
        url_taged_user = "href=\"\/users\/9999"
        post = FactoryGirl.create :post, user_id: user_post.id, topic_id: knowledge_topic.id,
          work_space_id: work_space.id, content: url_taged_user
        notified_users = User.get_users_not_contain_id(user_post.id)
        post.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to match_array notified_users
        end
      end
    end
  end

  describe "When answer a post and turn on notification setting" do
    it "Send notification when answer a post without tag user" do
      answer = FactoryGirl.create :answer, user: user_answer, post: new_post
      answer.activities.each do |activity|
        expect(activity.notifications.map(&:user)).to contain_exactly user_post
      end
    end

    it "Send notification when answer a post within tag user" do
      url_taged_user = "href=\"\/users\/" + tagged_user.id.to_s
      answer = FactoryGirl.create :answer, user: user_hr_administrator, post: new_post, content: url_taged_user
      answer.activities.each do |activity|
        expect(activity.notifications.map(&:user)).to contain_exactly(user_post, tagged_user)
      end
    end
  end

  describe "When comment and turn on notification setting" do
    context "Send notification when comment a post" do
      it "without tag user" do
        comment = FactoryGirl.create :comment, user_id: user_comment.id, commentable: new_post
        comment.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly user_post
        end
      end

      it "within tag user" do
        url_taged_user = "href=\"\/users\/" + tagged_user.id.to_s
        comment = FactoryGirl.create :comment, user_id: user_comment.id, commentable: new_post,
          content: url_taged_user
        comment.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly(user_post, tagged_user)
        end
      end
    end

    context "Send notification when comment a answer" do
      it "without tag user" do
        comment = FactoryGirl.create :comment, user_id: user_comment.id, commentable: new_answer
        comment.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly user_answer
        end
      end

      it "within tag user" do
        url_taged_user = "href=\"\/users\/" + tagged_user.id.to_s
        comment = FactoryGirl.create :comment, user_id: user_hr_administrator.id, commentable: new_answer,
          content: url_taged_user
        comment.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly(user_answer, tagged_user)
        end
      end
    end
  end

  describe "When reaction and turn on notification setting" do
    context "Send notification when like love a answer" do
      it "like" do
        reaction = FactoryGirl.create :reaction, target_type: "like", user_id: user.id, reactiontable: new_answer
        reaction.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly new_answer.user
        end
      end
      it "love" do
        reaction = FactoryGirl.create :reaction, target_type: "heart", user_id: user.id, reactiontable: new_answer
        reaction.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly new_answer.user
        end
      end
    end
    context "Send notification when like a comment" do
      it "like" do
        reaction = FactoryGirl.create :reaction, target_type: "like", user_id: user.id, reactiontable: new_comment
        reaction.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly new_comment.user
        end
      end
    end
    context "Send notification when upvote downvote a comment" do
      it "upvote" do
        reaction = FactoryGirl.create :reaction, target_type: "upvote", user_id: user.id, reactiontable: new_post
        reaction.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly new_post.user
        end
      end
      it "downvote" do
        reaction = FactoryGirl.create :reaction, target_type: "downvote", user_id: user.id, reactiontable: new_post
        reaction.activities.each do |activity|
          expect(activity.notifications.map(&:user)).to contain_exactly new_post.user
        end
      end
    end
  end

  describe "When clip a post and turn on notification setting" do
    it "clip a post" do
      clip = FactoryGirl.create :clip,  user_id: user.id, post: new_post
      clip.activities.each do |activity|
        expect(activity.notifications.map(&:user)).to contain_exactly new_post.user
      end
    end
  end

  describe "When follow a user and turn on notification setting" do
    let(:relationship){FactoryGirl.create :relationship, follower_id: user.id, following_id: user_answer.id}
    it "follow a user" do
      relationship.activities.each do |activity|
        expect(activity.notifications.map(&:user)).to contain_exactly user_answer
      end
    end
  end

  describe "When improve a post and turn on notification setting" do
    let(:a_version){FactoryGirl.create :a_version, user_id: user.id, a_versionable: new_post}
    it "improve a post a user" do
      a_version.activities.each do |activity|
        expect(activity.notifications.map(&:user)).to contain_exactly new_post.user
      end
    end
  end
end
