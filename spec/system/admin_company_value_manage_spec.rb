require 'rails_helper'

RSpec.describe 'It manages company values', type: :system do
  before do
    admin = create(:admin)
    create(:company_value)
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if company values are listed?' do
    visit '/admins/company_values'
    expect(page).to have_button 'Edit'
    expect(page).to have_text 'Strenght'
  end

  it 'edits the title of company value' do
    visit '/admins/company_values'
    click_button 'Edit'
    fill_in 'Title', with: 'Perfection'
    click_button 'Update Company value'
    expect(page).to have_text 'Perfection'
    expect(page).to have_content 'Company value was edited successfully'
  end

  it 'deletes the company value' do
    visit '/admins/company_values'
    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Company value was deleted successfully'
  end

  it 'creates a new company value' do
    visit '/admins/company_values'
    click_button 'Create New Company value'
    fill_in 'Title', with: 'Honesty'
    click_button 'Create Company value'
    expect(page).to have_text 'Honesty'
    expect(page).to have_content 'Company value was created successfully'
  end
end
