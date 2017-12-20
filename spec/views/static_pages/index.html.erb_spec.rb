
require "rails_helper"

RSpec.describe "static_pages/index.html.erb", type: :view do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let(:post_1) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let(:post_2) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let(:comment) {FactoryGirl.create :comment, user_id: user.id,
    commentable_id: post_1.id, commentable_type: "Post"}
  let!(:posts) {[post_1, post_2]}

  it "index static pages" do
    assign(:posts, Kaminari.paginate_array(posts).page(1))
    assign :topUsers, [user]
    assign :recentComments, [comment]

    render
    expect(subject).to render_template('static_pages/_post')
    expect(subject).to render_template('static_pages/_recent_comments')
    expect(subject).to render_template('static_pages/_top_users')
  end
end
