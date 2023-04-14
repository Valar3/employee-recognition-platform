require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe 'confirmation email' do
    let(:order) {create(:order)}
    let(:mail) {described_class.with(order: order).confirmation_email.deliver_now}

    it 'renders the subject' do
      expect(mail.subject).to eq('Your order has been delivered')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([order.employee.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['valar@employeerp.co.uk'])
    end
  end
end
