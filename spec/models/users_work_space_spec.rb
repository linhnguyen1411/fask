require 'rails_helper'

RSpec.describe UsersWorkSpace, type: :model do

  context "association" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :work_space}
  end
end
