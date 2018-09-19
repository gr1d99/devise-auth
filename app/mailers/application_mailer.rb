class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEFAULT_APPLICATION_MAILER_FROM']

  layout 'mailer'
end
