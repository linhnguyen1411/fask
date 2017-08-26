require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:work_space) {FactoryGirl.create :work_space}
  let(:user) {FactoryGirl.create :user}
  let(:topic) {FactoryGirl.create :topic}

  describe "POST #create" do
    before do
      sign_in user
    end

    context "comment post" do
      let(:params) do
        {
          content: "content comment post",
          object_type: "post",
          object_id: FactoryGirl.create(:post,
            work_space: work_space,
            user: user,
            topic: topic
          ).id
        }
      end

      it do
        expect {post :create, params: {comment: params}, xhr: true}
          .to change(Comment, :count).by 1
      end
    end

    context "comment answer" do
      let(:post_1) do
        FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
      end
      let!(:answer) {FactoryGirl.create :answer, user: user, post: post_1}
      let(:params) do
        {
          content: "content comment answer",
          object_type: "answer",
          object_id: answer.id
        }
      end

      it do
        expect {post :create, params: {comment: params}, xhr: true}
          .to change(Comment, :count).by 1
      end
      before {post :create, params: {comment: params}, format: :html}

      it {expect(response).to redirect_to post_path(assigns :object)}
    end
  end
end
