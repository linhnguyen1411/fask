require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let!(:tag) {FactoryGirl.create :tag}

  describe "GET index" do
    before do
      sign_in user
    end

    let!(:answer) {FactoryGirl.create :answer, user: user, post: post}
    let(:comment) do
      FactoryGirl.create :comment, user_id: user.id, commentable_id: post.id,
        commentable_type: "Post"
    end

    before {get :index}

    it {expect(assigns :posts).to eq [post]}
    it {expect(assigns :topUsers).to eq [user]}
    it {expect(assigns :recentComments).to eq [comment]}

    context "when params[:page] is present" do
      before do
        get :index, params: {page: 1}
      end

      it {expect(response).to be_success}
      it {expect(assigns :posts).to eq [post]}
    end

    context "when params[:tag_id] is nil" do
      it {expect(assigns :posts).to eq [post]}
    end

    context "when params[:tag_id] is present" do
      before do
        get :index, params: {tag_id: tag.id}
      end

      it "don't have posts" do
        expect(assigns :posts).to eq []
      end

      it "have posts" do
        FactoryGirl.create :posts_tag, post_id: post.id, tag_id: tag.id
        expect(assigns :posts).to eq [post]
        expect(assigns :tags).to eq [tag]
      end
    end
  end
end
