require 'rails_helper'

RSpec.describe Dashboard::FeedbacksController, type: :controller do

  let(:work_space) { FactoryGirl.create :work_space}
  let(:user){FactoryGirl.create :user, work_space: work_space}
  let(:user_eo){FactoryGirl.create :user, work_space: work_space, position: "Event Officer"}
  let(:topic_qa){FactoryGirl.create :knowledge_topic}
  let(:topic_fb){FactoryGirl.create :feedback_topic}
  let!(:tag){FactoryGirl.create :tag}
  let!(:the_post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_qa
  end
  let!(:post_x) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_fb,
    status: 0, created_at: DateTime.new(2016,03,01)

  end
  let!(:post_y) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_fb,
     status: 1, created_at: DateTime.new(2016,02,01)
  end
  let!(:post_z) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic_fb,
     status: 2, created_at: DateTime.new(2016,01,01)
  end

  describe "GET index" do

    context "check user authenticated view list feedback" do
      before do
        sign_in user_eo
        get :index
      end
      it{ expect(subject.status).to eq 200 }
    end

    context "check user not authenticated view list feedback" do
      before do
        sign_in user
        get :index
      end
      it{ expect(subject.status).to eq 302 }
    end

    context "get all post feedback" do
      before do
        sign_in user_eo
        get :index
      end
      it "fail" do
        expect(assigns(:feedback_support).all_feedback_posts).not_to eq([the_post])
      end

      it "success" do
        expect(assigns(:feedback_support).all_feedback_posts).to eq([post_x, post_y, post_z])
      end
    end
  end

  describe "Update" do
    context "update status feedback with unauthenticated user" do
      before do
        sign_in user
        post :update, params: {id: post_x.id, status: 2}
      end
      it{ expect(subject.status).to eq 302 }
    end

    context "update post is not exist" do
      before do
        sign_in user_eo
        post :update, params: {id: 10000}
      end
      it{ expect(subject.status).to eq 302 }
      it{ expect(subject).to redirect_to root_path }
    end

    context "update post with authenticated user and right params" do
      before do
        sign_in user_eo
        post :update, params: {id: post_x, post: {status: "accept"}}, xhr: true
      end
      it "assigns @success" do
        expect(assigns(:success)).to eq true
      end
    end

    context "update post with authenticated user and wrong params" do
      before do
        sign_in user_eo
        allow_any_instance_of(Post).to receive(:save).and_return false
        post :update, params: {id: post_x, post: {status: "reject"}}, xhr: true
      end
      it "assigns @success" do
        expect(assigns(:success)).to eq false
      end
    end
  end
end
