Given /^I am in index page$/ do
  visit root_path
end

Then /^I see text field search$/ do
  page.assert_selector "input", id: "index-field-search"
end

Then /^I see button home$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.home")
end

Then /^I see button help$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.help")
end

Then /^I see button mobile app$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.mobile_app")
end

Then /^I see button search$/ do
  page.assert_selector "a", text: I18n.t("static_pages.index.search")
end

Then /^I see button sign in$/ do
  page.assert_selector "a", id: "index-btn-search"
end

Then /^I see choose item Qa-Knowledge$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.q_a")
end

Then /^I see choose item Feedback$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.feedback")
end

Then /^I see choose item Confesstion$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.confession")
end

Then /^I see choose item Post Question$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.post_question")
end

Then /^I see choose item Recent Question$/ do
  page.assert_selector "a", text: I18n.t("static_pages.index.recent_question")
end

Then /^I see choose item Recently Answer$/ do
  page.assert_selector "a", text: I18n.t("static_pages.index.recently_answered")
end

Then /^I see choose item Top Views$/ do
  page.assert_selector "a", text: I18n.t("static_pages.index.top_views")
end

Then /^I see choose item Top Vote$/ do
  page.assert_selector "a", text: I18n.t("static_pages.index.top_votes")
end

Then /^I see button sign up$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.signup")
end

Then /^I dont see image avatar$/ do
  page.assert_no_selector "img", class: "image-profile"
end

Then /^I dont see button sign up$/ do
  page.assert_no_selector "a", text: I18n.t("layouts.header.signup")
end

Then /^I see image avatar$/ do
  page.assert_selector "img", class: "image-profile"
end

Then /^I see button login$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.login")
end

Then /^I dont see button login$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.login")
end

Then /^I see dropdown change language$/ do
  page.assert_selector "div", class: "change-language"
end
