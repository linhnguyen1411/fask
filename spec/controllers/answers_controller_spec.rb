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
end
