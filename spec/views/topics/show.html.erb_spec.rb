require "rails_helper"

RSpec.describe "topics/show.html.erb", type: :view do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post_1) do
    FactoryGirl.create :post, user: user, topic: topic
  end
  let!(:post_2) do
    FactoryGirl.create :post, user: user, topic: topic
  end

  it "show view all of topic page" do
    render "topics/view_all",
      params: {id: topic.id, type: Settings.topic.type_sort.recently},
      type: Settings.topic.type_sort.popular,
      work_space_id: work_space.id
    expect(rendered).to render_template("topics/_view_all")
  end

  it "show posts of topic page" do
    render "topics/post", posts: [post_1, post_2]
    expect(rendered).to render_template("topics/_post")
  end
end
