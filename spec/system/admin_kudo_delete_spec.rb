require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let!(:kudo) { create(:kudo) }

  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it 'kudos#delete?' do
    visit 'admins/kudos'
    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Kudo was deleted successfully')
  end
end
