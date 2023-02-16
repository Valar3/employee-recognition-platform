require 'rails_helper'

RSpec.describe 'Manage', type: :system do
  before do
    employee = create(:employee)
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
    employee.number_of_available_kudos = 0
  end

  it '0_available_kudo' do
    visit root_path
    expect(page).to have_text('You have used all your kudos')
  end
end
