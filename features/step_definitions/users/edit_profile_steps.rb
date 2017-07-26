#GIVEN
Given /^I am in edit page$/ do
  visit edit_user_registration_path
end

#WHEN
When /^I edit my name$/ do
  fill_in "user_name", with: "newname"
  fill_in "user_current_password", with: @visitor[:password]
end

When /^I edit my name without current password$/ do
  fill_in "user_name", with: "newname"
end

When /^I edit my password$/ do
  fill_in "user_password", with: "newpassword"
  fill_in "user_password_confirmation", with: "newpassword"
  fill_in "user_current_password", with: @visitor[:password]
end

When /^I edit my password without current password$/ do
  fill_in "user_password", with: "newpassword"
  fill_in "user_password_confirmation", with: "newpassword"
end

When /^I edit my password without password confirmation$/ do
  fill_in "user_password", with: "newpassword"
  fill_in "user_password_confirmation", with: "oldpassword"
  fill_in "user_current_password", with: @visitor[:password]
end

When /^I edit my password with mismatched confirmation$/ do
  fill_in "user_password", with: "newpassword"
  fill_in "user_password_confirmation", with: "oldpassword"
  fill_in "user_current_password", with: @visitor[:password]
end

When /^I edit my profile with invalid new password$/ do
  fill_in "user_password", with: "1234"
  fill_in "user_password_confirmation", with: "1234"
  fill_in "user_current_password", with: @visitor[:password]
end

When /^I edit my profile with invalid current password$/ do
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_current_password", with: @visitor[:password] + "123"
end

When /^I submit edit form$/ do
  click_button "Update"
end

#THEN
Then /^I see an account edited message$/ do
  expect(page).to have_content I18n.t("devise.registrations.updated")
end

Then /^I see a current password missing message$/ do
  expect(page).to have_content "Current password can't be blank"
end

Then /^I see a invalid current password message$/ do
  expect(page).to have_content "Current password is invalid"
end
