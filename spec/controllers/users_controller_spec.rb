require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  describe "GET #index" do
    let!(:users) {FactoryGirl.create_list :user, 2, work_space_id: work_space.id}
    context "when user not login" do
      before {get :index}

      it {expect(subject.status).to eq 302}
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
    let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }

    context "when load user success" do
      before {get :show, params: {id: user}}

      it {expect(assigns :user).to eq user}
    end

    context "when load user failed" do
      before {get :show, params: {id: 0}}

      it {expect(assigns(:user)).to eq nil}
    end
  end


  describe "PUT #update" do
    let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
    before {sign_in user}

    context "update successful when valid current password" do
      before do
        put :update,
        params: {id: user.id, current_password: "Aa@123", new_password: "123456"},
        xhr: true
      end
      let(:result) {{type: true, mess: I18n.t("profile.update_password.success")}}

      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [result.to_json]}
    end

    context "update failure when valid current password" do
      before do
        put :update,
        params: {id: user.id, current_password: "Aa@123", new_password: ""},
        xhr: true
      end
      let(:result) {{type: false, mess: I18n.t("profile.update_password.error")}}

      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [result.to_json]}
    end

    context "when invalid current password" do
      before do
        put :update,
        params: {id: user.id, current_password: "123456", new_password: "123456"},
        xhr: true
      end
      let(:result) {{type: false, mess: I18n.t("profile.update_password.current_password_wrong")}}

      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [result.to_json]}
    end
  end
end
