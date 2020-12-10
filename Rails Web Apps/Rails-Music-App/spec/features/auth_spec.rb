require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'email', :with => "testing@email.com"
      fill_in 'Password', :with => "biscuits"
      click_on "Create User"
    end

    # scenario "redirects to sign-in page after signup" do
    #   expect(page).to have_content "Successfully created your account! Check your inbox for an activation email."
    # end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'email', :with => "testing@email.com"
      click_on "Create User"
    end

    scenario "re-renders the signup page after failed signup" do 
        expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end

  end

end
