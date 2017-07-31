require "rails_helper"

RSpec.describe Topic, type: :model do

  context "association" do
    it{is_expected.to have_many :posts}
    it{is_expected.to have_and_belong_to_many :users}
  end
end
