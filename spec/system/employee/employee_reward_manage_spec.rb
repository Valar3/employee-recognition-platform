require 'rails_helper'

RSpec.describe 'It manages rewards', type: :system do
  let!(:reward) { create(:reward) }

  before do
    employee = create(:employee)
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if rewards are listed?' do
    visit '/employees/rewards'
    expect(page).to have_button 'Show'
    expect(page).to have_text reward.title
  end

  it 'check if the description is under the show button' do
    visit '/employees/rewards'
    click_button 'Show'
    expect(page).to have_text reward.description
  end

  it 'checks if points get substracted after buying reward' do
    visit 'employees/rewards'
    click_button 'Buy with post'
    fill_in 'order_city', with: 'London'
    fill_in 'order_street', with: 'Baker Street'
    fill_in 'order_postcode', with: '12345'
    click_button 'Create Order'
    expect(page).to have_text(100 - reward.price.to_i)
  end

  it 'checks if the rewards bought are listed for the current employee' do
    visit employees_rewards_path
    click_button 'Buy with post'
    fill_in 'order_city', with: 'London'
    fill_in 'order_street', with: 'Baker Street'
    fill_in 'order_postcode', with: '12345'
    click_button 'Create Order'
    visit root_path
    click_button 'Current Employee Reward List'
    expect(page).to have_text reward.title
  end
end
