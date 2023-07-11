require 'rails_helper'

RSpec.describe 'Signing up process', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to sign up an employee' do
    visit '/employees/sign_up'
    fill_in 'Name', with: 'John'
    fill_in 'Surname', with: 'Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'employee_password', with: 'password'
    fill_in 'employee_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
