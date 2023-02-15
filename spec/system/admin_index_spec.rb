require 'rails_helper'

RSpec.describe 'Listing', type: :system do
  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it '#index?' do
    visit '/admin/kudos'
    expect(page).to have_content 'Kudos listing page'
  end
end
