require "rails_helper"

RSpec.describe FollowsController, type: :controller do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let(:user_a) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:user_b) { FactoryGirl.create :user, work_space_id: work_space.id }

  describe "PUT #update" do
    context "when user not login" do
      before {put :update, params: {id: user_a.id}, xhr: true}
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [""]}

    end

    context "when user login and follow other user" do
      before do
        sign_in user_a
        put :update, params: {id: user_b.id}, xhr: true
      end

      let(:response_body) do
        {type: true, relationships: Settings.relationships.follow}
      end
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
        {type: true, relationships: Settings.relationships.unfollow}
      }
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end
  end
end
