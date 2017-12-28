
require "rails_helper"

RSpec.describe "static_pages/index.html.erb", type: :view do
  let(:work_space) { FactoryGirl.create :work_space}
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let(:posts) do
    FactoryGirl.create_list :post, 2, work_space: work_space, user: user, topic: topic
  end
  let(:comment) {FactoryGirl.create :comment, user_id: user.id,
    commentable_id: posts.first.id, commentable_type: "Post"}

  it "index static pages" do
    assign(:posts, Post.page(1).post_full_includes.newest.accept.per(10))
    assign :topUsers, [user]
    assign :recentComments, [comment]

    render
    expect(subject).to render_template('static_pages/_post')
    expect(subject).to render_template('static_pages/_recent_comments')
    expect(subject).to render_template('static_pages/_top_users')
  end
end
