require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:work_space) {FactoryGirl.create :work_space}
  let(:user) {FactoryGirl.create :user}
  let(:topic) {FactoryGirl.create :topic}

  describe "GET index" do
    before do
      sign_in user
      get "index"
    end

    context "don't have activities" do
      it "when params[:page] is present" do
        expect(assigns :activities).to eq []
      end

      it "when params[:page] is null" do
        expect(assigns :activities).to eq []
      end
    end
  end
end
