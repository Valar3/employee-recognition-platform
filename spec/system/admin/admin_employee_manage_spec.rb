require 'rails_helper'

RSpec.describe 'It enables to manage employee accounts', type: :system do
  before do
    admin = create(:admin)
    create(:employee)
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if employees are listed?' do
    random_employee = create(:employee)
    visit '/admins/employees'
    expect(page).to have_text random_employee.email
  end

  it 'edits the profile with new details' do
    visit '/admins/employees'
    click_link 'Update profile'
    fill_in 'Email', with: 'example@gmail.com'
    fill_in 'Number of available kudos', with: '5'
    click_button 'Update Employee'
    expect(page).to have_text 'example@gmail.com'
  end

  it 'deletes the employee profile' do
    visit '/admins/employees'
    click_link 'Delete profile'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Employee account was deleted successfully'
  end
end
