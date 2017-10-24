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

#THEN
Then /^I return to the index page$/ do
  visit root_path
end

Then /^I should be signed out$/ do
  page.assert_no_selector "a", text: I18n.t("layouts.header.logout")
  page.assert_selector "a", text: I18n.t("layouts.header.signup")
  page.assert_selector "a", text: I18n.t("layouts.header.login")
end

Then /^I see a mismatched password confirmation message$/ do
  expect(page).to have_content "Password confirmation doesn't match Password"
end

Then /^I see a invalid password message$/ do
  expect(page).to have_content "Password is too short (minimum is 6 characters)"
end
