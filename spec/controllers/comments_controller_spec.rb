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

  describe "PATCH #update" do
    let(:post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
    end
    let(:comment) do
      FactoryGirl.create :comment, user_id: user.id, commentable_id: post.id,
        commentable_type: "Post"
    end
    let(:valid_params) do
      {
        id: comment.id,
        content: "content comment"
      }
    end
    let(:invalid_params) do
      {
        id: 0,
        content: "content comment"
      }
    end

    before do
      sign_in user
    end

    context "when params[:id] exist" do
      before {patch :update, params: valid_params, xhr: true}
      let(:result) do
        {
          type: true,
          content: "content comment"
        }
      end

      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [result.to_json]}
    end

    context "when params[:id] not exist" do
      before {patch :update, params: invalid_params, xhr: true}

      it {expect(subject.status).to eq 302}
      it {expect(flash[:danger]).to eq "Not found this object"}
    end
  end

  describe "DELETE #destroy" do
    let(:post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
    end
    let(:comment) do
      FactoryGirl.create :comment, user_id: user.id, commentable_id: post.id,
        commentable_type: "Post"
    end
    let(:valid_params) {{id: comment.id}}
    let(:invalid_params) {{id: 0}}

    before do
      sign_in user
    end

    context "when params[:id] exist" do
      let(:result) {{type: true}}
      before {patch :destroy, params: valid_params, xhr: true}

      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [result.to_json]}
    end

    context "when params[:id] not exist" do
      before {patch :destroy, params: invalid_params, xhr: true}

      it {expect(subject.status).to eq 302}
      it {expect(flash[:danger]).to eq "Not found this object"}
    end
  end
end
