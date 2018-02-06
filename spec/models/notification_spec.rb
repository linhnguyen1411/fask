require "rails_helper"

RSpec.describe Notification, type: :model do
  let(:work_space) { FactoryGirl.create :work_space}
  let!(:users){FactoryGirl.create_list :user, 2 }
  let(:user){FactoryGirl.create :user, work_space: work_space}
  let(:topic_qa){FactoryGirl.create :knowledge_topic}
  let(:topic_fb){FactoryGirl.create :feedback_topic}

  describe "#load_message" do
    describe "feedback post" do
      context "reject post" do
        let!(:the_post) do
          FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_fb, status: "waiting"
        end
        let(:message){ I18n.t("posts.status.feedback_reject") }
        it do
          the_post.update_attributes status: "reject"
          expect(Notification.last.load_message).to eq [message, the_post.id]
        end
      end

      context "accept post" do
        let!(:the_post) do
          FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_fb, status: "waiting"
        end
        let(:message){ I18n.t("posts.status.feedback_info") }
        it do
          the_post.update_attributes status: "accept"
          expect(Notification.last.load_message).to eq [message, the_post.id]
        end
      end
    end

    context "tag user in post" do
      let!(:the_post) do
        url_taged_user = "href=\"\/users\/" + users.first.id.to_s
        FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_qa,
        content: url_taged_user
      end
      let(:message){ I18n.t("noti.tag_post") + " \"#{the_post.title}\"" }
      it {expect(Notification.first.load_message).to eq [message, the_post.id]}
    end

    describe "Q&A post" do
      let!(:the_post) do
        FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_qa
      end
      context "create Q&A post" do
        let(:message){ I18n.t("noti.create_post") + " \"#{the_post.title}\"" + I18n.t("noti.in_topic") + "#{the_post.topic.name}" }
        it { expect(Notification.last.load_message).to eq [message, the_post.id]}
      end

      context "answer post" do
        let!(:answer) do
          url_taged_user = "href=\"\/users\/" + users.first.id.to_s
          FactoryGirl.create :answer,
          user_id: user.id,
          post_id: the_post.id,
          created_at: DateTime.new(2016, 01, 01)

          FactoryGirl.create :answer,
          user_id: users.second.id,
          post_id: the_post.id,
          created_at: DateTime.new(2016, 03, 01),
          content: url_taged_user
        end
        let(:message_tag_user){ I18n.t("noti.tag_answer") + " \"#{the_post.title}\"" }
        let(:message_answer){ I18n.t("noti.answer_post") + " \"#{the_post.title}\"" }
        it {expect(Notification.third.load_message).to eq [message_tag_user, the_post.id]}
        it { expect(Notification.fourth.load_message).to eq [message_answer, the_post.id]}
      end

      context "comment post" do
        let!(:comment) do
          url_taged_user = "href=\"\/users\/" + users.first.id.to_s
          FactoryGirl.create :comment,
          user_id: user.id,
          commentable: the_post,
          created_at: DateTime.new(2016, 01, 01)

          FactoryGirl.create :comment,
          user_id: users.second.id,
          commentable: the_post,
          created_at: DateTime.new(2016, 03, 01),
          content: url_taged_user
        end
        let(:message_tag_user){ I18n.t("noti.tag_comment") + " \"#{the_post.title}\"" }
        let(:message_comment){ I18n.t("noti.comment_post") + " \"#{the_post.title}\"" }
        it {expect(Notification.third.load_message).to eq [message_tag_user, the_post.id]}
        it { expect(Notification.fourth.load_message).to eq [message_comment, the_post.id]}
      end

      context "comment answer" do
        let(:answer) do
          FactoryGirl.create :answer,
          user_id: user.id,
          post_id: the_post.id,
          created_at: DateTime.new(2016, 01, 01)
        end
        let!(:comment) do
          url_taged_user = "href=\"\/users\/" + users.first.id.to_s
          FactoryGirl.create :comment,
          user_id: user.id,
          commentable: answer,
          created_at: DateTime.new(2016, 01, 01)

          FactoryGirl.create :comment,
          user_id: users.second.id,
          commentable: answer,
          created_at: DateTime.new(2016, 03, 01),
          content: url_taged_user
        end
        let(:message_tag_user){ I18n.t("noti.tag_comment") + " \"#{the_post.title}\"" }
        let(:message_comment){ I18n.t("noti.comment_answer") + I18n.t("noti.in_post") + " \"#{the_post.title}\"" }
        it {expect(Notification.third.load_message).to eq [message_tag_user, the_post.id]}
        it { expect(Notification.fourth.load_message).to eq [message_comment, the_post.id]}
      end

      context "upvote post" do
        let!(:reaction){Reaction.create target_type: "upvote", user_id: users.first.id, reactiontable: the_post}
        let(:item){ I18n.t("noti.your_post") + " \"#{the_post.title}\"" }
        let(:message){ I18n.t("noti.have") + I18n.t("noti.upvote")  + item }
        it {expect(Notification.third.load_message).to eq [message, the_post.id]}
      end

      context "like answer" do
        let(:answer) do
          FactoryGirl.create :answer,
          user_id: user.id,
          post_id: the_post.id,
          created_at: DateTime.new(2016, 01, 01)
        end
        let!(:reaction){Reaction.create target_type: "like", user_id: users.first.id, reactiontable: answer}
        let(:item){ I18n.t("noti.your_answer") + I18n.t("noti.in_post") + " \"#{the_post.title}\"" }
        let(:message){ I18n.t("noti.have") + I18n.t("noti.like")  + item }
        it {expect(Notification.third.load_message).to eq [message, the_post.id]}
      end

      context "heart comment of post" do
        let(:comment) do
          FactoryGirl.create :comment,
          user_id: user.id,
          commentable: the_post,
          created_at: DateTime.new(2016, 01, 01)
        end
        let!(:reaction){Reaction.create target_type: "heart", user_id: users.first.id, reactiontable: comment}
        let(:item){ I18n.t("noti.your_comment") + I18n.t("noti.in_post") + " \"#{the_post.title}\"" }
        let(:message){ I18n.t("noti.have") + I18n.t("noti.heart")  + item }
        it {expect(Notification.third.load_message).to eq [message, the_post.id]}
      end

      context "heart comment of answer" do
        let(:answer) do
          FactoryGirl.create :answer,
          user_id: user.id,
          post_id: the_post.id,
          created_at: DateTime.new(2016, 01, 01)
        end
        let!(:comment) do
          FactoryGirl.create :comment,
          user_id: user.id,
          commentable: answer,
          created_at: DateTime.new(2016, 01, 01)
        end
        let!(:reaction){Reaction.create target_type: "heart", user_id: users.first.id, reactiontable: comment}
        let(:item){ I18n.t("noti.your_comment") + I18n.t("noti.in_post") + " \"#{the_post.title}\"" }
        let(:message){ I18n.t("noti.have") + I18n.t("noti.heart")  + item }
        it {expect(Notification.third.load_message).to eq [message, the_post.id]}
      end

      context "clip post" do
        let!(:clip) do
          FactoryGirl.create :clip,
          user_id: users.second.id,
          post_id: the_post.id
        end
        let(:message){ I18n.t("noti.clip_post") + " \"#{the_post.title}\"" }
        it {expect(Notification.third.load_message).to eq [message, the_post.id]}
      end

      context "improve post" do
        let!(:aversion) do
          FactoryGirl.create :a_version,
          user_id: users.second.id,
          a_versionable: the_post,
          status: "waiting"
        end

        let(:message){ I18n.t("noti.suggested_changes") + " \"#{the_post.title}\"" }
        let(:message_respond){ " accept" + I18n.t("version.your_improvement") }
        it {expect(Notification.third.load_message).to eq [message, the_post.id]}
        it do
          aversion.update_attributes status: "accept"
          expect(Notification.fourth.load_message).to eq [message_respond, the_post.id]
        end
      end

      context "relationship" do
        let!(:relationship){FactoryGirl.create :relationship, follower_id: user.id, following_id: users.first.id}
        let(:message){ I18n.t("noti.follow_user") }
        it {expect(Notification.third.load_message).to eq [message, users.first.id]}
      end
    end
  end
end
