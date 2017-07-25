require "rails_helper"

RSpec.describe Topic, type: :model do
 
  context "association" do
    it{is_expected.to have_many :topic_managers}
    it{is_expected.to have_many :users}
    it{is_expected.to have_many :posts}
  end
end
