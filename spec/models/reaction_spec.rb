require "rails_helper"

RSpec.describe Reaction, type: :model do

  context "association" do
    it{is_expected.to belong_to :user}
  end
end
