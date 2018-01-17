require "rails_helper"

RSpec.describe "posts/new.html.erb", type: :view do
  let(:work_space) { FactoryGirl.create :work_space}
  let!(:new_post) {Post.new}
  let(:categories) { FactoryGirl.create_list :category, 5}
  subject {Supports::PostSupport.new }
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  before {sign_in user}

  it "show new page" do
    assign :post, new_post
    assign :categories, categories
    assign :support, subject

    render
  end
end
