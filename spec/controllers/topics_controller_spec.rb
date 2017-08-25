require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "GET #show" do
    let(:topic) {FactoryGirl.create :topic}
    before {get :show, params: {id: topic}}

    context "when load topic success" do
      it {expect(assigns :support).to be_a Supports::PostSupport}
    end
  end
end
