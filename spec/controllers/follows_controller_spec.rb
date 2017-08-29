require "rails_helper"

RSpec.describe FollowsController, type: :controller do
  let!(:user_a){FactoryGirl.create :user}
  let!(:user_b){FactoryGirl.create :user}

  describe "PUT #update" do
    context "when user not login" do
      before {put :update, params: {id: user_a.id}, xhr: true}

      let(:response_body) {{type: Settings.error}}
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end

    context "when user login and follow other user" do
      before do
        sign_in user_a
        put :update, params: {id: user_b.id}, xhr: true
      end

      let(:response_body) {
        {type: Settings.success, relationships: Settings.relationships.follow}
      }
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end

    context "when user login and unfollow other user" do
      before do
        sign_in user_a
        user_a.active_relationships.new.update_attributes following_id: user_b.id
        put :update, params: {id: user_b.id}, xhr: true
      end

      let(:response_body) {
        {type: Settings.success, relationships: Settings.relationships.unfollow}
      }
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end
  end
end
