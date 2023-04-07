require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  before do
    email = OrderMailer.create_confirmation_email('admin@big_company.com', 'balonw@gmail.com', Time.now)
    email.deliver_now
  end
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
