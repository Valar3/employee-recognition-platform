  require "rails_helper"

RSpec.describe "Kudo management", :type => :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "enables me to create kudos" do
    visit "/kudos/new?"
    fill_in("kudo[title]", with: title)
    fill_in "Content", :with => "My content"
    click_button "Save Kudo"

    expect(page).to have_text("Kudo was created successfully.")
  end
end
