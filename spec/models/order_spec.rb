require "rails_helper"

RSpec.describe 'OrderMailer', type: :system do
  before do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    create(:order)
  end
  it 'checks if the email is sent'do
    visit 'admins/employees/orders'
    click_button 'Deliver'
     expect do
      described_class.run(order: order).to have_enqueued_job.on_queue('mailers').exactly(:once)
   end
  end
    it 'checks if the sender is present' do
      
    end
end
