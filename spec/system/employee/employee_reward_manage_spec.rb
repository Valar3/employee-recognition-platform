require 'rails_helper'

RSpec.describe 'It manages rewards', type: :system do
  before do
    employee = create(:employee)
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if rewards are listed?' do
    random_reward = create(:reward)
    visit '/employees/rewards'
    expect(page).to have_button 'Show'
    expect(page).to have_text random_reward.title
  end

  it 'check if the description is under the show button' do
    random_reward = create(:reward)
    visit '/employees/rewards'
    click_button 'Show'
    expect(page).to have_text random_reward.description
  end

  it 'checks if points get substracted after buying reward' do
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
    expect(page).to have_text(100 - random_reward.price.to_i)
  end

  it 'checks if the rewards bought are listed for the current employee' do
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
    visit root_path
    click_button 'Current Employee Reward List'
    expect(page).to have_text random_reward.title
  end
end
