require 'rails_helper'

RSpec.describe 'Signing in and out process', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to sign out an employee' do
    employee = create(:employee)
    visit '/employees/sign_in'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit root_path
    click_link 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
