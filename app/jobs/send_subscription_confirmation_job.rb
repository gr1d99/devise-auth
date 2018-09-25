class SendSubscriptionConfirmationJob < ApplicationJob
  queue_as :default

  def perform(notification_params)
    SubscriptionMailer.with(
      email: notification_params[:email],
      confirmation_url: notification_params[:confirmation_url]
    ).send_confirmation.deliver_later
  end
end
