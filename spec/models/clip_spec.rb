require "rails_helper"

RSpec.describe Clip, type: :model do

  context "association" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :post}
  end
end
