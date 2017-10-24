require "rails_helper"

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:valid_params) {{name: "Framgia"}}
  let(:invalid_params) {{name: nil}}

  before :each do
     @request.env["devise.mapping"] = Devise.mappings[:user]
     sign_in user
   end

  describe "GET #edit" do
    before {get :edit}

    context "when don't have activities" do
      it {expect(assigns(:activities)).to eq nil}
    end
  end

  describe "PATCH #update" do
    context "with valid parrams" do
      before do
        patch :update, params: {user: valid_params}
        user.reload
      end

      it {expect(user.name).to eq "Framgia"}
      it {expect(flash[:success]).to eq "Update profile success."}
    end

    context "with invalid params" do
      before do
        patch :update, params: {user: invalid_params}
        user.reload
      end

      it {expect(user.name).to eq user.name}
      it {expect(flash[:danger]).to eq "Update profile error."}
    end
  end
end
