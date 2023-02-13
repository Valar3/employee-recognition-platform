require 'rails_helper'

RSpec.describe 'Signing in and out process', type: :system do
  before do
    employee = create(:employee)
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to sign out an employee' do
    visit root_path
    click_link 'Sign out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
