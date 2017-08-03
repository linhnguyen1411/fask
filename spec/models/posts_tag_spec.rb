require 'rails_helper'

RSpec.describe PostsTag, type: :model do

  context "association" do
    it{is_expected.to belong_to :post}
    it{is_expected.to belong_to :tag}
  end
end
