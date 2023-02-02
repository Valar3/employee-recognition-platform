require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  before do
    employee = create(:employee)
    login_as(employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to create kudos' do
    visit root_path
    visit '/kudos/new?'
    fill_in 'kudo[title]', with: 'My kudo'
    fill_in 'kudo_content', with: 'My content'
    click_button 'Save Kudo'

    expect(page).to have_text('Kudo was created successfully')
  end
end
