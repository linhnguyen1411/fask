require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:users) {FactoryGirl.create_list :user, 2}

  describe "GET #index" do
    context "when user not login" do
      before {get :index}

      it {expect(response).to be_success}
      it {expect(assigns(:users)).to eq users}
    end

    context "when user login" do
      before do
        sign_in users.first
        get :index
        users.shift
      end

      it {expect(response).to be_success}
      it {expect(assigns(:users)).to eq users}
    end
  end

  describe "GET #show" do
    let(:user) {FactoryGirl.create :user}
      before {get :show, params: {id: user}}

      context "when load user success" do
        it {expect(assigns :user).to eq user}
      end

      context "when load post failed" do
        before {get :show, params: {id: 0}}

        it {expect(assigns(:user)).to eq nil}
      end
  end
end
