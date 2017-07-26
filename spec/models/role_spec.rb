require "rails_helper"

RSpec.describe Role, type: :model do
 
  context "association" do
    it{is_expected.to have_many :users}
  end
end
