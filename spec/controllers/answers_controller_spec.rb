require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:work_space) {FactoryGirl.create :work_space}
  let(:user) {FactoryGirl.create :user}
  let(:topic) {FactoryGirl.create :topic}

  let(:valid_params) do
    {
      content: "This is the post",
      post_id: FactoryGirl.create(:post, work_space: work_space, user: user, topic: topic).id,
      parent_id: 1
    }
  end

  let(:invalid_params) do
    {
      content: nil,
      post_id: nil,
      parent_id: nil
    }
  end

  describe "POST create" do
    context "with valid params" do
      let(:params) do
        {
          user_email: user.email,
          user_password: "Aa@123",
          answer: valid_params
        }
      end

      it {expect {post :create, params: params}.to change(Answer, :count).by 1}
    end

    context "with valid params and user_email, user_password are null" do
      it do
        expect {post :create, params: {answer: valid_params}}
          .to change(Answer, :count).by 0
      end
    end

    context "with params email not exist" do
      let(:params) do
        {
          user_email: "abc@gmail.com",
          user_password: "Aa@123",
          answer: valid_params
        }
      end

      it {expect {post :create, params: params}.to change(Answer, :count).by 0}
    end

    context "with post not exist" do
      let(:params) do
        {
          user_email: user.email,
          user_password: "Aa@123",
          answer: {
            content: "This is the post",
            post_id: 1,
            parent_id: 1
          }
        }
      end

      it {expect {post :create, params: params}.to change(Answer, :count).by 0}
    end

    context "when create fail" do
      let(:params) do
        {
          user_email: user.email,
          user_password: "Aa@123",
          answer: valid_params
        }
      end

      before {allow_any_instance_of(Answer).to receive(:save).and_return false}

      it {expect {post :create, params: params}.to change(Answer, :count).by 0}
    end
  end

  describe "PATCH #edit" do
    let(:post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
    end
    let!(:answer) do
      FactoryGirl.create :answer, user: user, post: post, best_answer: false
    end
    let(:valid_params) {{id: answer.id}}
    let(:invalid_params) {{id: 0}}

    before do
      sign_in user
    end

    context "when params[:id] exist" do
      before {patch :edit, params: valid_params, xhr: true}
      let(:result) {{sesulf: true}}

      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [result.to_json]}
    end

    context "when params[:id] not exist" do
      before {patch :edit, params: invalid_params, xhr: true}

      it {expect(subject.status).to eq 302}
      it {expect(flash[:danger]).to eq "Answer not exist"}
    end
  end
end
