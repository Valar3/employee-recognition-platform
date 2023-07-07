require 'rails_helper'

RSpec.describe 'It manages rewards', type: :system do
  let!(:reward) { create(:reward) }

  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    driven_by(:selenium_chrome_headless)
  end

  it 'checks if rewards are listed?' do
    random_reward = create(:reward)
    visit '/admins/rewards'
    expect(page).to have_button 'Edit'
    expect(page).to have_text random_reward.title
  end

  it 'edits the title of reward' do
    visit '/admins/rewards'
    click_button 'Edit'
    fill_in 'Title', with: 'A new car'
    fill_in 'Description', with: 'A super duper brand new car'
    fill_in 'Price', with: rand(1..999)
    click_button 'Update Reward'
    expect(page).to have_text 'A new car'
    expect(page).to have_content 'Reward was edited successfully'
  end

  it 'deletes the reward' do
    visit '/admins/rewards'
    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Reward was deleted successfully'
  end

  it 'creates a new reward' do
    visit '/admins/rewards'
    click_button 'Create New Reward'
    fill_in 'Title', with: 'Trampoline'
    fill_in 'Description', with: 'A super duper brand new trampoline'
    fill_in 'Price', with: rand(1..999)
    page.select reward.category.title, from: 'reward_category_id'
    click_button 'Create Reward'
    expect(page).to have_text 'trampoline'
    expect(page).to have_content 'Reward was created successfully'
  end

  it 'imports a csv file' do
    create(:category)
    visit '/admins/rewards/import'
    attach_file('file', Rails.root.join('spec/fixtures/files/rewards.csv').to_s)
    click_button 'Import'
    expect(page).to have_content 'Import completed'
  end
end
