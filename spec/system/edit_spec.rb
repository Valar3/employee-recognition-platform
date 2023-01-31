RSpec.describe "Kudo management", :type => :system do
  before do
    employee = FactoryBot.create(:employee)
    login_as(employee)
    driven_by(:selenium_chrome_headless)
  end
  it "enables me to edit kudos" do
    visit root_path
    visit kudos/edit/1/
