require "rails_helper"

RSpec.describe "topics/show.html.erb", type: :view do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post_1) do
    FactoryGirl.create :post, user: user, topic: topic
  end
  let!(:post_2) do
    FactoryGirl.create :post, user: user, topic: topic
  end
  subject {Supports::TopicSupport.new id: 1}
  it "show posts of topic page" do
    assign :topic, topic
    assign :support, subject
    sign_in user
    render
    expect(subject).to render_template("topics/_post")
  end
end
