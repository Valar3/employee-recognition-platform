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
end
