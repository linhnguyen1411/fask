require "rails_helper"

RSpec.describe Category, type: :model do
  context "association" do
    it{ is_expected.to have_many :children_categories }
    it{ is_expected.to have_many :posts }
    it{ is_expected.to belong_to :parent_category }
  end

  context "validation" do
    it{ should validate_presence_of(:name) }
  end
end
