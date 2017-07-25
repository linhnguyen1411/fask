#METHODS
def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def create_visitor
  @visitor ||= {name: "Visitor", email: "visitor@framgia.com",
    password: "Aa@123", password_confirmation: "Aa@123"}
end

def delete_user
  @user ||= User.find_by email: @visitor[:email]
  @user.destroy if @user.present?
end

def sign_in
  visit new_user_session_path
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  click_button "Log in"
end

def sign_up
  visit new_user_registration_path
  fill_in "user_name", with: @visitor[:name]
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def find_user
  @user ||= User.find_by email: @visitor[:email]
end


#GIVEN
Given /^I exist as a user$/ do
  create_user
end

Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

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

When /^I sign out$/ do
  visit destroy_user_session_path
end

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
Then /^I return to the index page$/ do
  visit root_path
end

Then /^I see a successful sign in message$/ do
  expect(page).to have_content I18n.t("devise.sessions.signed_in")
end

Then /^I should be signed in$/ do
  page.assert_selector "a", text: I18n.t("layouts.header.logout")
  page.assert_no_selector "a", text: I18n.t("layouts.header.siguup")
  page.assert_no_selector "a", text: I18n.t("layouts.header.login")
end

Then /^I should be signed out$/ do
  page.assert_no_selector "a", text: I18n.t("layouts.header.logout")
  page.assert_selector "a", text: I18n.t("layouts.header.signup")
  page.assert_selector "a", text: I18n.t("layouts.header.login")
end

Then /^I see an invalid login message$/ do
  expect(page).to have_content I18n.t("devise.failure.invalid", authentication_keys: :email)
end

Then /^I see a signed out message$/ do
  expect(page).to have_content I18n.t("devise.sessions.signed_out")
end

Then /^I see a successfull sign up message$/ do
  expect(page).to have_content I18n.t("devise.registrations.signed_up")
end

Then /^I see a missing email message$/ do
  expect(page).to have_content "Email can't be blank"
end

Then /^I see a missing password message$/ do
  expect(page).to have_content "Password can't be blank"
end

Then /^I see a missing password confirmation message$/ do
  expect(page).to have_content "Password confirmation doesn't match Password"
end

Then /^I see a invalid password message$/ do
  expect(page).to have_content "Password is too short (minimum is 6 characters)"
end

Then /^I see a already exist email message$/ do
  expect(page).to have_content "Email has already been taken"
end

Then /^I am still in sign in page$/ do
   expect(current_path).to eql new_user_session_path
end
