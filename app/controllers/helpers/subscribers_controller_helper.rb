# frozen_string_literal: true

module SubscribersControllerHelper
  def handle_subscription_notification
    subscriber = Subscriber.find_by(subscribe_params)
    return new_subscriber unless subscriber
    return existing_subscriber(subscriber) unless subscriber.is_confirmed
    handle_redirection(root_path, already_subscribed_msg)
  end

  def send_subscription(subscriber)
    SendSubscriptionConfirmationService.call(subscriber)
  end

  def new_subscriber
    new_subscriber = Subscriber.create(subscribe_params)
    send_subscription(new_subscriber)
    handle_redirection(root_path, new_confirmation_msg)
  end

  def existing_subscriber(subscriber)
    send_subscription(subscriber)
    handle_redirection(root_path, unconfirmed_subscription_msg)
  end

  def handle_subscription_confirmation(subscriber)
    message = if subscriber.is_confirmed
                already_subscribed_msg
              else
                ConfirmSubscriptionService.call(subscriber)
                successful_subscription_msg
              end

    handle_redirection(root_path, message)
  end

  private

  def handle_redirection(path, message)
    # TODO: NEEDS REFACTORING, MAYBE TO A CONCERN
    redirect_to path, notice: message
  end

  def email_required_msg
    'Subscription E-mail address is required'
  end

  def new_confirmation_msg
    'We have sent you confirmation email, '\
    'please check your email to complete '\
    'subscription'
  end

  def unconfirmed_subscription_msg
    'We have sent you confirmation email again, '\
    'please check your email to complete '\
    'subscription'
  end

  def successful_subscription_msg
    'You have successfully subscribed'
  end

  def already_subscribed_msg
    'Thanks but you are already subscribed'
  end

  def invalid_token_msg
    'The link you used is invalid, please subscribe again'
  end
end
