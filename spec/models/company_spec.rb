require "rails_helper"

RSpec.describe Company, type: :model do
 
  context "association" do
    it{is_expected.to have_many :work_spaces}
    it{is_expected.to have_many :users}
    it{is_expected.to belong_to :owner}
  end
end
