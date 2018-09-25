# frozen_string_literal: true

module MailerHelpers
  def last_email
    ActionMailer::Base.deliveries.last
  end
end

RSpec.configure do |config|
  config.include MailerHelpers, type: :controller
  config.include MailerHelpers, type: :service
  config.include MailerHelpers, type: :job
end
