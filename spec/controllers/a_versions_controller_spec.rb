require "rails_helper"

RSpec.describe AVersionsController, type: :controller do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post_x) do
    FactoryGirl.create :post, user_id: user.id, topic_id: topic.id, count_view: 3,
      created_at: DateTime.new(2016, 01, 01)
  end

  before do
    sign_in user
  end
  describe "GET #index" do
    let!(:a_versions) do
      FactoryGirl.create :a_version, user_id: user.id, status: :waiting,
       a_versionable_id: post_x.id, a_versionable_type: post_x.class.name
    end
    context "get all version" do
      before do
        get :index, params: {post_id: post_x.id}
      end
      it {expect(assigns[:version_of_post]).to eq [a_versions]}
    end
  end

  describe "POST #create" do
    it "new improvement with full params" do
      expect{
        post :create, params: {a_version: {content: "1234567890", post_id: post_x.id}}
      }.to change(AVersion, :count)
    end

    it "new improvement with missing params" do
      expect{
        post :create, params: {a_version: { post_id: post_x.id}}
      }.to_not change(AVersion, :count)
    end

    it "new improvement with wrong post" do
        post :create, params: {a_version: { post_id: 500}}
      response.should redirect_to(root_path)
    end
  end

  describe "PUT #update" do
    let!(:a_versions) do
      FactoryGirl.create :a_version, user_id: user.id, status: :waiting,
       a_versionable_id: post_x.id, a_versionable_type: post_x.class.name
    end

    it "update version content" do
      put :update,xhr: true, params: {id: a_versions.id,
        a_version: {content: "abcdefgh abcdefgh"},post_id: post_x.id}
      a_versions.reload
      expect(a_versions.content).to eq("abcdefgh abcdefgh")
    end

    it "update version with action accept" do
      put :update, params: {id: a_versions.id ,status: "accept",
        type: post_x.class.name, post_id: post_x.id}, xhr: true
      a_versions.reload
      expect(a_versions.status).to eq("accept")
    end

    it "update version with action reject" do
      put :update, params: {id: a_versions.id ,status: "reject",
        type: post_x.class.name, post_id: post_x.id}, xhr: true
      a_versions.reload
      expect(a_versions.status).to eq("reject")
    end
  end

  describe "DELETE #destroy" do
    let!(:a_versions) do
      FactoryGirl.create :a_version, user_id: user.id, status: :waiting,
       a_versionable_id: post_x.id, a_versionable_type: post_x.class.name
    end
    it "delete a version if exist" do
      aversion_count = AVersion.count
      delete :destroy, params: {id: a_versions.id }, xhr: true
      expect(AVersion.count).to eq(aversion_count - 1)
    end
    it "delete a version if not exist" do
      aversion_count = AVersion.count
      delete :destroy, params: {id: 1000 }, xhr: true
      expect(AVersion.count).to eq(aversion_count)
    end
  end
end
