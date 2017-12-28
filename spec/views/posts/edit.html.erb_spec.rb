require "rails_helper"

RSpec.describe "posts/edit.html.erb", type: :view do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post) {FactoryGirl.create :post, user_id: user.id, topic_id: topic.id}
  let(:tags) {FactoryGirl.create_list :tag, 5}
  subject {Supports::PostSupport.new post}

  it "show edit page" do
    assign :post, post
    assign :support, subject

    render
  end
end
