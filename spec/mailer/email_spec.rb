require 'spec_helper'

describe "Passwor Reset" do
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    click_link "Forgot your password?"
    fill_in "Email", with: user.email
    click_button "Send me reset password instructions"
    expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
    ## last_email from spec_helper.rb/ returns last email
    expect(last_email.to).to include(user.email)
  end
  
  it "does not email invalid user when requesting password reset" do
    visit new_user_session_path
    click_link "Forgot your password?"
    fill_in "Email", with: "bad_email@not_in_db.com"
    click_button "Send me reset password instructions"
    expect(page).to have_content("Email not found")
    ## last_email from spec_helper.rb/ returns last email
    expect(last_email).to be_nil
  end
end
