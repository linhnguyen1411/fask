require "rails_helper"

RSpec.describe "posts/new.html.erb", type: :view do
  let!(:new_post) {Post.new}
  let(:categories) { FactoryGirl.create_list :category, 5}
  subject {Supports::PostSupport.new }
  it "show new page" do
    assign :post, new_post
    assign :categories, categories
    assign :support, subject

    render
  end
end
