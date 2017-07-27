Given /^I see logo$/ do
  page.assert_selector "img", id: "fask-logo"
end

When /^I am click logo$/ do
  find('#fask-logo').click
end

Then /^Redirect to root page$/ do
  visit root_path
end

When /^I am click button home$/ do
  click_link I18n.t("layouts.header.home")
end

Then /^Redirect to home page$/ do
  visit root_path
end

When /^I am click button help$/ do
  click_link I18n.t("layouts.header.help")
end

Then /^Redirect to help page$/ do
  visit help_path
end

When /^I am click button app mobile$/ do
  click_link I18n.t("layouts.header.mobile_app")
end

Then /^Redirect to app mobile page$/ do
  visit mobile_page_path
end

When /^I am click choose Qa-Knowledge$/ do
  click_link I18n.t("layouts.header.q_a")
end

Then /^Redirect to Qa-Knowledge page$/ do
  visit qa_knowledges_path
end

When /^I am click choose Feedback$/ do
  click_link I18n.t("layouts.header.feedback")
end

Then /^Redirect to Feedback page$/ do
  visit feedbacks_path
end

When /^I am click choose Confesstion$/ do
  click_link I18n.t("layouts.header.confession")
end

Then /^Redirect to Confesstion page$/ do
  visit confessions_path
end
