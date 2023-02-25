require 'rails_helper'

RSpec.describe 'Listing', type: :system do
  before do
    admin = create(:admin)
    create(:kudo)
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it '#index?' do
    visit '/admins/kudos'
    expect(page).to have_content 'my first factory kudo'
  end
end
