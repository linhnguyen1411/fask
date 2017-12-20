require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "GET #show" do
    let(:company) { FactoryGirl.create :company }
    let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
    let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
    let(:topic){FactoryGirl.create :knowledge_topic}
    before do
      sign_in user
      get :show, params: {id: topic}
    end

    context "when load topic success" do
      it {expect(assigns :support).to be_a Supports::PostSupport}
    end
  end
end
