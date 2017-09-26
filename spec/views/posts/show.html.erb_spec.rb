require "rails_helper"

RSpec.describe "posts/show.html.erb", type: :view do
  let!(:user) {FactoryGirl.create :user}
  let!(:topic) {FactoryGirl.create :topic}
  let!(:post) {FactoryGirl.create :post, user_id: user.id, topic_id: topic.id}
  let!(:answer) {FactoryGirl.create :answer, user_id: user.id, post_id: post.id}
  let!(:comment) {FactoryGirl.create :comment, user_id: user.id,
    commentable_id: post.id, commentable_type: Post.name}
  let!(:new_answer) {Answer.new}
  let!(:post_extension) {Supports::PostSupport.new(Post, nil, nil, nil, nil)}

  it "show post page when user login" do
    assign :post, post
    assign :answer, new_answer
    assign :post_extension, post_extension
    sign_in user

    render
    expect(subject).to render_template("posts/_comment")
    expect(subject).to render_template("comments/_create")
    expect(subject).to render_template("posts/_answer")
    expect(subject).to render_template("posts/_extension_post")
  end

  it "show post page when user not login" do
    assign :post, post
    assign :answer, new_answer
    assign :post_extension, post_extension

    render
    expect(subject).to render_template("posts/_comment")
    expect(subject).to render_template("posts/_answer")
    expect(subject).to render_template("posts/_extension_post")
  end
end
