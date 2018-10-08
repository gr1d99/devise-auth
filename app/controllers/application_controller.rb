# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    @error_message = 'Page not found'
    render :'errors/not_found', status: :not_found
  end
end
