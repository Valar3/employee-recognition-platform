require 'rails_helper'

RSpec.describe 'Importing online codes', type: :system do
  let!(:admin) { create(:admin) }
  let!(:reward1) { create(:reward, id: 80) }
  let!(:reward2) { create(:reward, id: 93) }
  let!(:reward3) { create(:reward, id: 72) }

  before do
    login_as(admin, scope: :admin)
  end

  it 'imports online codes and displays appropriate messages' do
    visit 'admins/online_codes/import_online_codes'
    attach_file('file', Rails.root.join('spec/fixtures/files/valid_online_codes.csv'))
    click_button('Import')
    expect(page).to have_content('Import completed')
  end
end
