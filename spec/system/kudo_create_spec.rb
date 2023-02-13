require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to create kudos' do
    employee = create(:employee)
    visit '/employees/sign_in'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit root_path
    visit 'kudos/new'
    fill_in 'kudo[title]', with: 'My kudo'
    fill_in 'kudo_content', with: 'My content'
    click_button 'Save Kudo'

    expect(page).to have_text('Kudo was created successfully')
  end
end
