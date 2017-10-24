require "rails_helper"

RSpec.describe "topics/show.html.erb", type: :view do
  let(:user) {FactoryGirl.create :user}
  let(:topic) {FactoryGirl.create :topic}
  let!(:post_1) do
    FactoryGirl.create :post, user: user, topic: topic
  end
  let!(:post_2) do
    FactoryGirl.create :post, user: user, topic: topic
  end

  it "show view all of topic page" do
    render "topics/view_all",
      params: {id: topic.id, type: Settings.topic.type_sort.recently},
      type: Settings.topic.type_sort.popular
    expect(rendered).to render_template("topics/_view_all")
  end

  it "show posts of topic page" do
    render "topics/post", posts: [post_1, post_2]
    expect(rendered).to render_template("topics/_post")
  end
end
