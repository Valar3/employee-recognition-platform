require 'rails_helper'

RSpec.describe 'It enables to manage employee accounts', type: :system do
  let!(:employee) { create(:employee) }
  let!(:admin) { create(:admin) }

  before do
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

  it 'checks if the rewads are listed in admin/employee panel' do
    login_as(employee, scope: :employee)
    random_reward = create(:reward)
    visit 'employees/rewards'
    click_button 'Buy'
    page.select 'post_delivery', from: 'reward_delivery_method'
    click_button 'Submit'
    expect(page).to have_text 'You have chosen Post delivery as your delivery method'
    fill_in 'order_city', with: 'London'
    fill_in 'order_street', with: 'Baker Street'
    fill_in 'order_postcode', with: '12345'
    click_button 'Create Order'
    login_as(admin, scope: :admin)
    visit 'admins/employees'
    click_link 'Show list'
    expect(page).to have_text random_reward.title
  end

  it 'checks if name is updated' do
    visit '/admins/employees'
    click_link 'Update profile'
    fill_in 'Name', with: 'John'
    click_button 'Update Employee'
    expect(page).to have_text 'John'
  end

  it 'checks if surname is updated' do
    visit '/admins/employees'
    click_link 'Update profile'
    fill_in 'Surname', with: 'Smith'
    click_button 'Update Employee'
    expect(page).to have_text 'Smith'
  end
end
