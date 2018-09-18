# frozen_string_literal: true

class SubscriptionMailer < ApplicationMailer
  default from: ENV['DEFAULT_SUBSCRIPTION_MAILER_FROM']
  default subject: 'Confirm Subscription'

  def send_confirmation
    @email = params[:email]
    @confirmation_url = params[:confirmation_url]

    mail(to: @email)
  end
end
