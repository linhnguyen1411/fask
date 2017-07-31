require "rails_helper"

RSpec.describe Relationship, type: :model do

  context "association" do
    it{expect belong_to :follower}
    it{expect belong_to :following}
  end
end
