require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
    let(:mail) { OrderMailer.confirmation_email(@order) }
  before do
    login_as(admin, scope: :admin)
  end
  visit 

    it 'checks the subject' do
    expect(mail.subject).to eq('Your order has been delivered')
  end

  it 'checks the sender' do
    expect(mail.from).to eq('admin@big_company.com')
  end

  it 'checks the recipient'do
    expect(mail.to).to eq('balonw@gmail.com')
end

end
