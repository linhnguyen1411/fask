require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let(:tag) {FactoryGirl.create :tag}

  describe "GET #index" do
    before do
      sign_in user
      get :index
    end

    context "don't have tags" do
      it {expect(assigns :tags).to eq []}
    end

    context "have tags" do
      let!(:post_tags) {FactoryGirl.create :posts_tag, post_id: post.id, tag_id: tag.id}

      it {expect(assigns :tags).to eq [tag]}
    end
  end
end
