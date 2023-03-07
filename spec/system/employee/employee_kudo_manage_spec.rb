require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee) }

  before do
    login_as(employee, scope: :employee)
    driven_by(:selenium_chrome_headless)
  end

  it 'enables me to edit kudos' do
    random_company_value = create(:company_value)
    visit root_path
    click_button 'Edit'
    fill_in 'Title', with: 'A new title'
    fill_in 'Content', with: 'A new content'
    page.select random_company_value.title, from: 'kudo_company_value_id'
    click_button 'Update Kudo'
    expect(page).to have_text('Kudo was edited successfully')
    expect(page).to have_text('A new title')
    expect(page).to have_text(random_company_value.title)
  end

  it 'enables me to delete kudos' do
    visit root_path
    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Kudo was deleted successfully')
  end

  it 'enables me to create kudos' do
    visit root_path
    visit 'employees/kudos/new'
    fill_in 'kudo[title]', with: 'My kudo'
    fill_in 'kudo_content', with: 'My content'
    page.select kudo.company_value.title, from: 'kudo_company_value_id'
    click_button 'Create Kudo'
    expect(page).to have_text('Kudo was created successfully')
    expect(page).to have_text('My kudo')
  end

  context 'when user has 0 available kudos' do
    before do
      employee = create(:employee)
      login_as(employee, scope: :employee)
      employee.number_of_available_kudos = 0
    end

    it 'does not show create kudo button' do
      visit root_path
      expect(page).not_to have_button('Create New Kudo')
    end

    it 'does not allow to open create kudo page' do
      visit 'employees/kudos/new'
      expect(page).to have_text('You have used all your kudos')
    end
  end

  context 'when user receives a kudo' do
    before do
      create(:employee)
      login_as(employee, scope: :employee)
    end

    it 'shows the number of points' do
      employee.number_of_earned_points = 10
      visit root_path
      expect(page).to have_text('Total points earned: 10')
    end

    it 'substracts the points upon deletion' do
      login_as(kudo.giver, scope: :employee)
      employee.number_of_earned_points = 10
      visit root_path
      click_button 'Delete'
      page.driver.browser.switch_to.alert.accept
      login_as(employee, scope: :employee)
      visit root_path
      expect(page).to have_text('Total points earned: 0')
    end
  end
end
