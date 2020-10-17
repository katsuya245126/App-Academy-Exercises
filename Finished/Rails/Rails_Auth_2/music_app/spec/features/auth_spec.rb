require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      fill_in 'Password', :with => "biscuits"
      click_on "Sign up"
    end

    scenario "redirects to log in page after signup" do
      expect(page).to have_content "Log in"
      expect(page).to have_content "Sign up successful! Check your inbox for the verification email."
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      click_on "Sign up"
    end

    scenario "redirects to the signup page after failed signup" do
      expect(page).to have_content "New user"
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end

end
