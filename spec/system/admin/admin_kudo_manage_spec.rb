require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let!(:admin) { create(:admin) }

  before do
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if the index page is properly dispayed' do
    create(:kudo)
    visit '/admins/kudos'
    expect(page).to have_content 'my first factory kudo'
  end

  it 'kudos#delete?' do
    create(:kudo)
    visit 'admins/kudos'
    expect(page).to have_text('my first factory kudo')
    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Kudo was deleted successfully')
  end

  it 'checks if the add kudo to all feature is working correctly' do
    random_employee_1 = create(:employee)
    random_employee_2 = create(:employee)
    visit admin_root_path
    click_link 'Add Kudos to all'
    fill_in 'Number of available kudos',	with: 5
    click_button 'Save'
    random_employee_1.reload
    random_employee_2.reload
    expect(page).to have_text 'Successfully updated the number of kudos to all employees'
    expect(random_employee_1.number_of_available_kudos).to eq(15)
    expect(random_employee_2.number_of_available_kudos).to eq(15)
  end

  it 'checks if the constrains on the number of available kudos field work' do
    visit admin_root_path
    click_link 'Add Kudos to all'
    fill_in 'Number of available kudos',	with: 21
    click_button 'Save'
    expect(page).to have_text 'Invalid number of kudos, must be between 1 and 20.'
  end
end
