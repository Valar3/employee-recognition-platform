require 'rails_helper'

RSpec.describe OrderMailer, type: :system do
  let!(:order) { create(:order) }

  it 'checks if the email is sent' do
    expect do
      described_class.confirmation_email(order:).deliver_later
    end.to have_enqueued_job.on_queue('default').exactly(:once)
  end
end