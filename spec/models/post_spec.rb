require "rails_helper"

RSpec.describe Post, type: :model do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}

  let!(:post_x) do
    FactoryGirl.create :post,
    user_id: user.id,
    topic_id: topic.id,
    count_view: 3,
    created_at: DateTime.new(2016, 01, 01)
  end

  let!(:post_y) do
    FactoryGirl.create :post,
    user_id: user.id,
    topic_id: topic.id,
    count_view: 2,
    created_at: DateTime.new(2016, 02, 01)
  end

  let!(:post_z) do
    FactoryGirl.create :post,
    user_id: user.id,
    topic_id: topic.id,
    count_view: 1,
    created_at: DateTime.new(2016, 03, 01)
  end

  let!(:answer) do
    FactoryGirl.create :answer,
    user_id: user.id,
    post_id: post_x.id,
    created_at: DateTime.new(2016, 01, 01)

    FactoryGirl.create :answer,
    user_id: user.id,
    post_id: post_y.id,
    created_at: DateTime.new(2016, 02, 01)

    FactoryGirl.create :answer,
    user_id: user.id,
    post_id: post_z.id,
    created_at: DateTime.new(2016, 03, 01)
  end

  context "association" do
    it{is_expected.to have_many :reactions}
    it{is_expected.to have_many :clips}
    it{expect have_and_belong_to_many :tags}

    it{expect belong_to :user}
    it{is_expected.to belong_to :work_space}
    it{expect belong_to :topic}
    it{expect belong_to :category}
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

  context ".by_tags" do
    let(:tag) {FactoryGirl.create :tag}

    it "when tag_id is nil" do
      expect(Post.by_tags(nil).count).to eq 0
    end

    it "when tag_id is present" do
      FactoryGirl.create :posts_tag, post_id: post_x.id, tag_id: tag.id
      expect(Post.by_tags(tag.id).count).to be > 0
    end
  end

  context ".recently_comment" do
    it "don't have comment" do
      expect(Post.recently_comment.length).to eq 0
    end

    it "have comments" do
      FactoryGirl.create :comment, user_id: user.id, commentable_id: post_x.id,
        commentable_type: "Post"
      expect(Post.recently_comment.length).to be > 0
    end
  end

  context ".post_by_topic" do
    it "fail" do
      expect(Post.post_by_topic(0).count).to eq 0
    end

    it "success" do
      expect(Post.post_by_topic(topic.id).count).to be > 0
    end
  end

  context ".newest" do
    it "fail" do
      expect(Post.newest).not_to eq([post_x, post_y, post_z])
    end

    it "success" do
      expect(Post.newest).to eq([post_z, post_y, post_x])
    end
  end

  context ".popular" do
    it "fail" do
      expect(Post.popular).not_to eq([post_z, post_y, post_x])
    end

    it "success" do
      expect(Post.popular).to eq([post_x, post_y, post_z])
    end
  end

  context ".recently_answer" do
    it "fail" do
      expect(Post.recently_answer).not_to eq([post_x, post_y, post_z])
    end

    it "success" do
      expect(Post.recently_answer).to eq([post_z, post_y, post_x])
    end
  end

  context ".no_answer" do
    it "success" do
      expect(Post.no_answer.count).to eq 0
    end
  end

  context ".recently_answer" do
    it "fail" do
      expect(Post.recently_answer).not_to eq([post_x, post_y, post_z])
    end

    it "success" do
      expect(Post.recently_answer).to eq([post_z, post_y, post_x])
    end
  end

  context ".post_in_time" do
    it "fail" do
      expect(Post.post_in_time("2016/02/01","2016/03/01")).not_to eq([post_x])
    end

    it "success" do
      expect(Post.post_in_time("2016/02/01","2016/03/01")).to eq([post_y, post_z])
    end

    it "just from day" do
      expect(Post.post_in_time("2016/02/01","")).to eq([post_y, post_z])
    end

    it "just end day" do
      expect(Post.post_in_time("","2016/03/01")).to eq([post_x, post_y])
    end
  end
end
