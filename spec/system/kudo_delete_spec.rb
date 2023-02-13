require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee) }

  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to delete kudos' do
    visit '/employees/sign_in'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit 'employee'
    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Kudo was deleted successfully')
  end
end
