# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'valar@employeerp.co.uk'
  layout 'mailer'
end
