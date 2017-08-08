require 'rails_helper'

RSpec.describe TagUsersController, type: :controller do
  describe "GET index" do
    it "renders the :index template" do
      get :index, params: {key: "", format: :json}
      expect(response.content_type).to eq "application/json"
    end
  end
end
