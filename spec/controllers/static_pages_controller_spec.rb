require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  let(:work_space) {FactoryGirl.create :work_space}
  let(:user) {FactoryGirl.create :user}
  let(:topic) {FactoryGirl.create :topic}
  let!(:post) {FactoryGirl.create :post, work_space: work_space, user: user, topic: topic}

  describe "GET index" do
    before do
      get :index, params: {page: 1}
    end
    let!(:answer) {FactoryGirl.create :answer, user: user, post: post}
    let!(:comment) {FactoryGirl.create :comment, user: user, post: post, answer: answer}
    before {get :index}
    it {expect(assigns :posts).to eq [post]}

    context "when params[:page] is present" do
      it {expect(response).to be_success}
      it {expect(assigns :posts).to eq [post]}
    end

    it {expect(assigns :topUsers).to eq [user]}
    it {expect(assigns :recentComments).to eq [comment]}
  end
end
