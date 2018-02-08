require "rails_helper"

RSpec.describe "posts/index.html.erb", type: :view do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let(:post_1) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let(:post_2) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let!(:posts) {[post_1, post_2]}

  it "show index page" do
    assign :posts, Post.page(1).per(Settings.paginate_posts)

    render
  end
end
