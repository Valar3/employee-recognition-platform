require 'rails_helper'

RSpec.describe 'Order management', type: :system do
  let(:employee) { create(:employee) }
  let!(:online_code) { create(:online_code) }

  before do
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if the filtering options works [NOT DELIVERED]' do
    random_order = create(:order, employee:)
    visit 'employees/orders'
    click_link 'Not Delivered'
    expect(page).to have_text(random_order.reward.title)
  end

  it 'checks if the filtering options works [DELIVERED]' do
    random_order = create(:order, employee:)
    random_order.status = 1
    random_order.save
    visit 'employees/orders'
    click_link 'Delivered'
    expect(page).to have_text(random_order.reward.title)
  end

  it 'checks if you chose online delivery method there is an appropriate message' do
    online_code.reward.delivery_method = 'online'
    online_code.reward.save
    visit 'employees/rewards'
    click_button 'Buy online'
    expect(page).to have_text 'Order successfully processed'
  end

  it 'checks the validation of the address data' do
    order = create(:order, employee:)
    order.reward.delivery_method = 'online'
    order.reward.save
    visit 'employees/rewards'
    click_button 'Buy with post'
    fill_in 'order[city]', with: ''
    fill_in 'order[street]', with: ''
    fill_in 'order[postcode]', with: ''
    click_button 'Create Order'
    expect(page).to have_text 'City can\'t be blank'
    expect(page).to have_text 'Street can\'t be blank'
    expect(page).to have_text 'Postcode can\'t be blank'
  end

  it 'checks if the fields are pre filled if there is an address set on an employee' do
    visit 'employees/rewards'
    click_button 'Buy with post'
    expect(page).to have_field('order_city', with: employee.city)
    expect(page).to have_field('order_street', with: employee.street)
    expect(page).to have_field('order_postcode', with: employee.postcode)
  end
end
