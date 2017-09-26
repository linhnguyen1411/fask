require "rails_helper"

RSpec.describe "posts/edit.html.erb", type: :view do
  let!(:user) {FactoryGirl.create :user}
  let!(:topic) {FactoryGirl.create :topic}
  let!(:post) {FactoryGirl.create :post, user_id: user.id, topic_id: topic.id}
  let(:tags) {FactoryGirl.create_list :tag, 5}
  it "show edit page" do
    assign :post, post
    assign :tags, tags

    render
  end
end
