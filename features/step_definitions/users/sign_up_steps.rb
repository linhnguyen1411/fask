#MOTHODS
def sign_up
  visit new_user_registration_path
  fill_in "user_name", with: @visitor[:name]
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

#WHEN
When /^I sign up with valid user data$/ do
  create_visitor
  delete_user
  sign_up
end

When /^I sign up without password$/ do
  create_visitor
  delete_user
  @visitor[:password] = ""
  sign_up
end

When /^I sign up without password confirmation$/ do
  create_visitor
  delete_user
  @visitor[:password_confirmation] = ""
  sign_up
end

When /^I sign up without email$/ do
  create_visitor
  delete_user
  @visitor [:email] = ""
  sign_up
end

When /^I sign up with mismatched password confirmation$/ do
  create_visitor
  delete_user
  @visitor[:password] = "123456"
  sign_up
end

When /^I sign up with invalid password$/ do
  create_visitor
  delete_user
  @visitor[:password] = "12345"
  sign_up
end

When /^I sign up with already exist email$/ do
  create_visitor
  sign_up
  visit destroy_user_session_path
  sign_up
end

#THEN
Then /^I see a successfull sign up message$/ do
  expect(page).to have_content I18n.t("devise.registrations.signed_up")
end

Then /^I see a missing email message$/ do
  expect(page).to have_content "Email can't be blank"
end

Then /^I see a missing password message$/ do
  expect(page).to have_content "Password can't be blank"
end

Then /^I see a already exist email message$/ do
  expect(page).to have_content "Email has already been taken"
end
