# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@big_company.com'
  layout 'mailer'
end
