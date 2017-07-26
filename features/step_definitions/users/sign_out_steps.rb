#WHEN
When /^I sign out$/ do
  visit destroy_user_session_path
end

#THEN
Then /^I see a signed out message$/ do
  expect(page).to have_content I18n.t("devise.sessions.signed_out")
end
