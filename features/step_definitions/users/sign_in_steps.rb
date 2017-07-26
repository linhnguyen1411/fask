#WHEN
When /^I sign in with valid credentials$/ do
  sign_in
end

When /^I sign in with a wrong email$/ do
  @visitor[:email] = "wrong_email@framgia.com"
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor[:password]  = "wrongpass"
  sign_in
end

#THEN
Then /^I see a successful sign in message$/ do
  expect(page).to have_content I18n.t("devise.sessions.signed_in")
end

Then /^I see an invalid login message$/ do
  expect(page).to have_content I18n.t("devise.failure.invalid", authentication_keys: :email)
end

Then /^I should be signed in$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.logout")
  page.assert_no_selector "a", text: I18n.t("layouts.header.siguup")
  page.assert_no_selector "a", text: I18n.t("layouts.header.login")
end

Then /^I am still in sign in page$/ do
  expect(current_path).to eql new_user_session_path
end
