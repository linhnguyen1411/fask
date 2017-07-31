require "rails_helper"

RSpec.describe Comment, type: :model do

  context "association" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :answer}
    it{is_expected.to belong_to :post}
  end
end
