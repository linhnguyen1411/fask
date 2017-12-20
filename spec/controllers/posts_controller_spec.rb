require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let(:user){FactoryGirl.create :user, work_space: work_space}
  let(:topic_qa){FactoryGirl.create :knowledge_topic}
  let(:topic_fb){FactoryGirl.create :feedback_topic}
  let(:topic_cf){FactoryGirl.create :confesstion_topic}
  let!(:tag){FactoryGirl.create :tag}

  describe "GET index" do
    let(:post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_qa
    end

    before do
      sign_in user
    end

    context "when params[:query] and params[:page] is null" do
      before do
        get :index
      end
      it {expect(response).to be_success}
      it {expect(assigns(:posts)).to eq [post]}
    end

    context "when params[:page] is present" do
      before do
        get :index, params: {page: 1}
      end

      it {expect(response).to be_success}
      it {expect(assigns(:posts)).to eq [post]}
    end
  end

  describe "GET new" do
    before do
      sign_in user
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with invalid attributes" do
      it "new post Q-A toppic with not login" do
        expect{
          post :create, params: {
            post: {title: 1234567, content: "1234567", topic_id: topic_qa.id}}
        }.to_not change(Post, :count)
      end

      it "new post with toppic not exits" do
        sign_in user
        expect{
          post :create, params: {
            post: {title: 1234567, content: "1234567", topic_id: 0}}
        }.to_not change(Post, :count)
      end

      it "new post with title not exits" do
        sign_in user
        expect{
          post :create, params: {
            post: {title: nil, content: "1234567", topic_id: topic_cf.id}}
        }.to_not change(Post, :count)
      end
    end

    context "with valid attributes" do
      before do
        sign_in user
      end

      it "new post Feedback toppic with login and using anonymous" do
        expect{
          post :create, params: {
            anonymous: Settings.anonymous, post: {title: 1234567, content: "1234567",
            topic_id: topic_fb.id, work_space_id: work_space.id}}
        }.to change(Post, :count).by 1
      end

      it "new post Feedback toppic with login and not using anonymous" do
        expect{
          post :create, params: {post: {title: 1234567, content: "1234567",
            topic_id: topic_fb.id, work_space_id: work_space.id}}
        }.to_not change(Tag, :count)
      end

      it "new post Confesstion toppic with login" do
        expect{
          post :create, params: {anonymous: Settings.anonymous,
            post: {title: 1234567, content: "1234567", topic_id: topic_cf.id}}
        }.to change(Post, :count).by 1
      end

      it "new post Q-A toppic with login" do
        expect{
          post :create, params: {post: {title: 1234567, content: "1234567",
            topic_id: topic_qa.id}}
        }.to change(Post, :count).by 1
      end


      it "new post with tag already in the Database" do
        expect{
          post :create, params: {post: {title: 1234567, content: "1234567",
            topic_id: topic_cf.id}, tags: tag.name}
        }.to_not change(Tag, :count)
        tag_after = Tag.find_by id: tag.id
        expect(tag_after.used_count).to eq(tag.used_count + 1)
      end

      it "new post with tag not already in the Database" do
        expect{
          post :create, params: {post: {title: 1234567, content: "1234567",
            topic_id: topic_cf.id}, tags: "new_name"}
        }.to change(Tag, :count).by 1
      end
    end

    describe "GET #show" do
      let(:post) do
        FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_qa
      end

      before do
        sign_in user
        get :show, params: {id: post}
      end

      context "when load post success" do
        it {expect(assigns :post_extension).to be_a Supports::PostSupport}
        it {expect(assigns :answer).to be_a Answer}
        it {expect(assigns :post).to eq post}
      end

      context "when load post failed" do
        before {get :show, params: {id: post.id + 1}}

        it {expect(assigns :post_extension).to be_a Supports::PostSupport}
        it {expect(assigns :answer).to be_a Answer}
        it {expect(assigns(:post)).to eq nil}
      end
    end
  end
end
