require "rails_helper"

RSpec.describe "posts/new.html.erb", type: :view do
  let!(:new_post) {Post.new}
  let(:categories) { FactoryGirl.create_list :category, 5}
  it "show new page" do
    assign :post, new_post
    assign :categories, categories
    render
  end
end
