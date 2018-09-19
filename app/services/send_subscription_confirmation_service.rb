# frozen_string_literal: true

class SendSubscriptionConfirmationService
  attr_reader :subscriber

  def initialize(subscriber)
    @subscriber = subscriber
  end

  def call
    send_confirmation
  end

  def self.call(subscriber)
    new(subscriber).call
  end

  private

  def send_confirmation
    SubscriptionMailer.with(
      email: subscriber.email,
      confirmation_url: subscriber.confirmation_url
    ).send_confirmation.deliver_now
  end
end
