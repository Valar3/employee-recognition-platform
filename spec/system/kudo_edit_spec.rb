require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee) }

  before do
    login_as(employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to edit kudos' do
    visit root_path
    click_button 'Edit'
    fill_in 'Title', with: 'A new title'
    fill_in 'Content', with: 'A new content'
    click_button 'Update Kudo'
    expect(page).to have_text('Kudo was edited successfully')
  end
end
