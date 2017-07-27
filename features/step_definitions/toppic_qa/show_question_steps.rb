def create_post
  tag = new FactoryGirl.create :tag
  @user = FactoryGirl.create :user
  company = FactoryGirl.create :company, owner_id: @user.id
  work_space = FactoryGirl.create :work_space, company_id: company.id
  topic = FactoryGirl.create :topic
  @post = FactoryGirl.create :post, work_space_id: work_space.id, topic_id: topic.id, user_id: @user.id
  PostTag.create post_id: @post.id, tag_id: tag.id
end

def create_answer
  @answer = FactoryGirl.create post_id: @post.id, user_id: @user.id, parent_is: 0
end

def create_answer_with conent
  @answer = FactoryGirl.create content: content, post_id: @post.id, user_id: @user.id, parent_is: 0
end

Given /^server not have question$/ do
  Post.destroy_all
end

Given /^I see message question not exist$/ do
  page.assert_selector "label", text: I18n.t("static_pages.index.question_not_exist")
end

Given /^server have question$/ do
  create_post
end

Then /^I see question$/ do
  page.assert_selector "div", class: "list-question"
end

Then /^I see name of question$/ do
  page.assert_selector "div", class: "title", text: @post.name
end

Then /^I see content of question$/ do
  page.assert_selector "div", class: "content", text: @post.content
end

Then /^I see number view of question$/ do
  page.assert_selector "div", class: "question-view-counts", text: @post.view_counts
end

Then /^I see number tag of question$/ do
  page.assert_selector "div", class: "question-tag-counts", text: @post.tags.size
end

Then /^I see number vote of question$/ do
  page.assert_selector "div", class: "question-vote-counts",
    text: (@post.reactions.upvote.size - @post.reactions.downvote.size)
end

Then /^I see button upvote question$/ do
  page.assert_selector "a", id: "btn-upvote-question"
end

Then /^I see button downvote question$/ do
  page.assert_selector "a", id: "btn-downvote-question"
end

When /^I click button upvote$/ do
  find("#btn-upvote-question").click
end

When /^I click button upvote but I downvoted to question$/ do
  find("#btn-downvote-question").click
  find("#btn-upvote-question").click
end

Then /^I see message voted to question$/ do
  expect(page).to have_content I18n.t("qa_knowlegeds.show.error_voted_question")
end

When /^I click button downvote$/ do
  find("#btn-downvote-question").click
end

When /^I click button downvote but I downvoted to question$/ do
  find("#btn-upvote-question").click
  find("#btn-downvote-question").click
end

Given /^server have answers$/ do
  create_answer
end

Then /^I see answers$/ do
  page.assert_selector "div", class: "content-answer", text: @answer.content
end

Then /^I see number like of answer$/ do
  page.assert_selector "div", class: "answer-like-count", text: @answer.reactions.like.size
end

Then /^I see number dislike of answer$/ do
  page.assert_selector "div", class: "answer-dislike-count", text: @answer.reactions.dislike.size
end

When /^I click button like$/ do
  find("#btn-like-answer-#{@answer.id}").click
end

Then /^I see number like of answer reduced$/ do
  page.assert_selector "div", class: "answer-like-count", text: @answer.reactions.like.size
end

When /^I click button like but I liked to answer$/ do
  find("#btn-like-answer-#{@answer.id}").click
  find("#btn-like-answer-#{@answer.id}").click
end

Then /^I see message liked to answer$/ do
  expect(page).to have_content I18n.t("qa_knowlegeds.show.error_liked_question")
end

When /^I click button like but I disliked to answer$/ do
  find("#btn-dislike-answer-#{@answer.id}").click
  find("#btn-like-answer-#{@answer.id}").click
end

Then /^I see number dislike to answer$/ do
  page.assert_selector "div", class: "answer-dislike-count", text: @answer.reactions.like.size
end

When /^I click button dislike$/ do
  find("#btn-dislike-answer-#{@answer.id}").click
end

When /^I click button dislike but I disliked to answer$/ do
  find("#btn-dislike-answer-#{@answer.id}").click
  find("#btn-dislike-answer-#{@answer.id}").click
end

Then /^I see message disliked to answer$/ do
  expect(page).to have_content I18n.t("qa_knowlegeds.show.error_disliked_question")
end

When /^I click button dislike but I liked to answer$/ do
  find("#btn-like-answer-#{@answer.id}").click
  find("#btn-dislike-answer-#{@answer.id}").click
end

Then /^I see number like to answer$/ do
  page.assert_selector "div", class: "answer-like-count", text: @answer.reactions.like.size
end

When /^I click button answer with content nil$/ do
  create_answer_with ""
end

Then /^I see message create answer error$/ do
  expect(page).to have_content I18n.t("qa_knowlegeds.show.create_answer_error")
end

When /^I click button answer with present content$/ do
  create_answer_with "Answer hav content"
end

Then /^I see message  create answer success$/ do
  expect(page).to have_content I18n.t("qa_knowlegeds.show.create_answer_success")
end

Then /^I see content answer on page$/ do
  expect(page).to have_content "Answer hav content"
end
