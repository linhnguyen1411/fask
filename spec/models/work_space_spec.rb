require "rails_helper"

RSpec.describe WorkSpace, type: :model do
 
  context "association" do
    it{is_expected.to have_many :posts}
    it{is_expected.to belong_to :company}
  end
end
