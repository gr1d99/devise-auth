# frozen_string_literal: true

class SubscribersController < ApplicationController
  include SubscribersControllerHelper

  def subscribe
    if subscribe_params[:email].empty?
      redirect_to root_url, notice: email_required_msg
    else
      handle_subscription_notification
    end
  end

  def confirm
    subscriber = Subscriber.find_by_token(confirm_params[:token])
    unless subscriber
      redirect_to root_path,
                  notice: invalid_token_msg
      return
    end

    handle_subscription_confirmation(subscriber)
  end

  private

  def subscribe_params
    params.permit(:email)
  end

  def confirm_params
    params.permit(:token)
  end
end
