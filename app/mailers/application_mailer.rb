class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILER_EMAIL_SENDER']
  layout 'mailer'
end
