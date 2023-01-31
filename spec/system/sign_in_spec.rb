require "rails_helper"

RSpec.describe "Signing in and out process", :type => :system do
  before do
    employee = FactoryBot.create(:employee)
    driven_by(:selenium_chrome_headless)
  end
  it "enables me to sign in an employee" do
    visit '/employees/sign_in'
      fill_in 'Email', with: 'balonw1@gmail.com'
      fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
