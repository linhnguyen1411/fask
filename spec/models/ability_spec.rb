require "cancan/matchers"
require 'rails_helper'
describe "Ability" do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:anonymous) { FactoryGirl.create :user, id: 1, work_space_id: work_space.id }
  let(:user) { FactoryGirl.create :user, id: 2, work_space_id: work_space.id }
  subject(:ability){ Ability.new(anonymous) }

  context "when is an account anonymous" do
    it{ should be_able_to(:read, Post.new) }
    it{ should be_able_to(:read, Reaction.new) }
    it{ should be_able_to(:read, User.new) }
    it{ should be_able_to(:create, Post.new) }
  end
  context "when isn't an account anonymous" do
    subject(:ability){ Ability.new(user) }
    it{ should be_able_to(:create, User.new) }
  end
end
