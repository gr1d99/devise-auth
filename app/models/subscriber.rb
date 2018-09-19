# frozen_string_literal: true

class Subscriber < ApplicationRecord
  validates :email, presence: true
  validates :token, uniqueness: true

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def confirmation_url
    root_url =
      Rails.application.routes.url_helpers.root_url(
        host: ENV['APP_HOST'], port: ENV['APP_PORT']
      )
    "#{root_url}subscribe/confirm/#{token}"
  end

  before_create do
    self.token = generate_token
  end
end
