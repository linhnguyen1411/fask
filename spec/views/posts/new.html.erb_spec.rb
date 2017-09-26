require "rails_helper"

RSpec.describe "posts/new.html.erb", type: :view do
  let!(:new_post) {Post.new}

  it "show new page" do
    assign :post, new_post

    render
  end
end
