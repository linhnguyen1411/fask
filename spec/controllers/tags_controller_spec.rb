require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "GET index" do
    it "renders the :index template" do
      get :index, params: {key: "", format: :json}
      binding.pry
      expect(response.content_type).to eq "application/json"
    end
  end
end
