require "rails_helper"

RSpec.describe Company, type: :model do
  context "association" do
    it{ is_expected.to have_many :categories }
    it{ is_expected.to have_many :work_spaces }
  end

  context "validation" do
    it{ should validate_presence_of(:name) }
  end
end
