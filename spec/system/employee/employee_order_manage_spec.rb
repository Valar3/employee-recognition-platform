require 'rails_helper'

RSpec.describe 'Order management', type: :system do
  let(:employee) { create(:employee) }
  let!(:order) { create(:order, employee:) }

  before do
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if the filtering options works [NOT DELIVERED]' do
    visit 'employees/orders'
    click_link 'Not Delivered'
    expect(page).to have_text(order.reward.title)
  end

  it 'checks if the filtering options works [DELIVERED]' do
    order.status = 1
    order.save
    visit 'employees/orders'
    click_link 'Delivered'
    expect(page).to have_text(order.reward.title)
  end

  it 'checks if you chose online delivery method there is an appropriate message' do
    create(:reward)
    visit 'employees/rewards'
    click_button 'Buy online'
    expect(page).to have_text 'Order processed successfully'
  end

  it 'checks the validation of the address data' do
    random_reward = create(:reward)
    random_reward.delivery_method = 'post_delivery'
    random_reward.save
    login_as(employee, scope: :employee)
    visit 'employees/rewards'
    click_button 'Buy with post'
    click_button 'Create Order'
    expect(page).to have_text 'City can\'t be blank'
    expect(page).to have_text 'Street can\'t be blank'
    expect(page).to have_text 'Postcode can\'t be blank'
  end

  it 'checks if the fields are pre filled if there is an address set on an employee' do
    create(:reward)
    @reward.delivery_method = 'post_delivery'
    @reward.save
    visit 'employees/rewards'
    click_button 'Buy with post'
    expect(page).to have_field('order_city', with: employee.city)
    expect(page).to have_field('order_street', with: employee.street)
    expect(page).to have_field('order_postcode', with: employee.postcode)
  end
end
