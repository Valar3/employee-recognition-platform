require 'rails_helper'

RSpec.describe 'Manage order object', type: :system do
  let(:employee) { create(:employee) }
  let(:admin) { create(:admin) }

  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'check if the order price remains unchanged when admins change the price' do
    random_reward = create(:reward)
    login_as(employee, scope: :employee)
    visit 'employees/rewards'
    click_button 'Buy'
    login_as(admin, scope: :admin)
    visit 'admins/rewards'
    click_button 'Edit'
    fill_in 'Price',	with: '59'
    click_button 'Update Reward'
    login_as(employee, scope: :employee)
    visit root_path
    click_button 'Current Employee Reward List'
    expect(page).to have_text random_reward.price
  end

  it 'checks if the order is delivered' do
    login_as(admin, scope: :admin)
    create(:employee)
    create(:order)
    visit 'admins/employees/orders'
    click_button 'Deliver'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text 'Order was successfully delivered'
  end
end
