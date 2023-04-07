require "rails_helper"

class OrderMailerTest < ActionMailer::TestCase
  test 'send confirmation' do
     email = OrderMailer.create_confirmation_email('admin@big_company.com', 'balonw@gmail.com')
     assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['admin@big_company.com'], email.from
    assert_equal ['balonw@gmail.com'], email.to
    assert_equal ['Your order has been delivered'], email.subject
    assert_equal read_fixture("confirmation_email").join, email.body.to_s
  end
end
