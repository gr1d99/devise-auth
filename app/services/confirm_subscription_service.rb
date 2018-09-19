# frozen_string_literal: true

class ConfirmSubscriptionService
  attr_reader :subscriber

  def initialize(subscriber)
    @subscriber = subscriber
  end

  def call
    confirm
  end

  def self.call(subscriber)
    new(subscriber).call
  end

  private

  def confirm
    subscriber.update_column(:is_confirmed, true)
  end
end
