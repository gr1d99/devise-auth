# frozen_string_literal: true

module ApplicationHelper
  def owner?(instance)
    return false unless current_user
    return false unless instance.respond_to?(:user)
    instance.send(:user).eql?(current_user)
  end
end
