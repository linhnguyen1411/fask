require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) {FactoryGirl.create :work_space, company_id: company.id}
  let(:user) {FactoryGirl.create :user, work_space_id: work_space.id}
  let(:user_a) {FactoryGirl.create :user, work_space_id: work_space.id}
  let(:topic) {FactoryGirl.create :knowledge_topic}
  let(:feedback_topic) {FactoryGirl.create :feedback_topic}

  before do
    sign_in user
  end

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
          answer: valid_params
        }
      end
      it {expect {post :create, params: params}.to change(Answer, :count).by 1}
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

    context "when create second answer of post in feedback topic " do
      let(:post_1) {FactoryGirl.create(:post, work_space: work_space, user: user, topic: feedback_topic)}
      let!(:answer){FactoryGirl.create :answer, content: "The first answer of post",
        post_id: post_1.id, parent_id: 1, user_id: user.id}
      let(:params) do
        {
          content: "The second answer for post in feedback topic",
          post_id: post_1.id,
          parent_id: 1
        }
      end

      it do
        expect {post :create, params: {answer: params}}
          .to change(Answer, :count).by 0
      end

    end
  end

  describe "PATCH #edit" do
    let(:post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
    end
    let!(:answer) do
      FactoryGirl.create :answer, user: user_a, post: post, best_answer: false
    end
    let(:valid_params) {{id: answer.id}}
    let(:invalid_params) {{id: 0}}


    context "user edit owner answer with edit_params" do
      let(:params) do
        {
          edit_content: "True",
          id: answer.id
        }
      end
      let(:result) {{type: false}}
      before do
        get :edit, params: params, xhr: true
      end
      it {expect(subject.status).to eq 200}
    end

    context "user edit owner answer with non edit_params" do
      let(:params) do
        {
          id: answer.id
        }
      end
      before do
        get :edit, params: params, xhr: true
      end
      it {expect(subject.status).to eq 200}
    end

    context "owner post choose correct answer" do
      let(:params) {{ id: answer.id }}
      let(:result) {{type: true}}
      before :each do
        request.env["HTTP_ACCEPT"] = 'application/json'
      end
      before do
        get :edit, params: params
      end
      it {expect(subject.response_body).to eq [result.to_json]}
    end
  end

  describe "PATCH #update" do
    let(:feedback_post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: feedback_topic
    end
    let!(:answer) do
      FactoryGirl.create :answer, user: user_a, post: feedback_post, best_answer: false
    end
    let(:hr_user) do
      FactoryGirl.create :user, work_space_id: work_space.id, position: "Hr administrator"
    end
    let(:params_answer) do
      {
        content: "this update answer with HR user",
        post_id: feedback_post.id
      }
    end
    let(:valid_params) do
      {
        id: answer.id,
        edit_content: true,
        answer: params_answer
      }
    end
    let(:invalid_params) do
      {
        id: answer.id,
        edit_content: true,
        answer:
          {
            content: "",
            post_id: 9999
          }
      }
    end
    before do
      sign_in hr_user
    end
    context "update answer of post in feedback topic with user permitted and valid params" do
      before do
        patch :update, params: valid_params, xhr: true
      end
      it {expect(subject.status).to eq 200}
    end

    context "update answer of post in feedback topic with user not permitted and valid params" do
      before do
        sign_in user_a
        patch :update, params: valid_params, xhr: true
      end
      it {expect(subject.status).to eq 200}
    end

    context "update answer of post in feedback topic with user permitted and invalid params" do
      before do
        patch :update, params: invalid_params, xhr: true
      end
      it {expect(subject.status).to eq 200}
    end
  end

  describe "DELETE destroy" do
    let(:feedback_post) do
      FactoryGirl.create :post, work_space: work_space, user: user, topic: feedback_topic
    end
    let!(:answer) do
      FactoryGirl.create :answer, user: user_a, post: feedback_post, best_answer: false
    end
    let(:hr_user) do
      FactoryGirl.create :user, work_space_id: work_space.id, position: "Hr administrator"
    end
    context "Delete fail with wrong user" do
      before do
        post :destroy, params: {id: answer.id}, xhr: true
      end
      it {expect(subject.status).to eq 302}
    end
    context "Delete success with correct user" do
      before do
        sign_in user_a
        post :destroy, params: {id: answer.id}, xhr: true
      end
      it {expect(subject.status).to eq 200}
    end
    context "delete fail with wrong answer id" do
      before do
        post :destroy, params: {id: 9999}, xhr: true
      end
      it {expect(subject.status).to eq 302}
    end
  end
end
