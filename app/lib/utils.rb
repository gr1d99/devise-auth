# frozen_string_literal: true

module AppUtils
  def self.pluralize_klass(klass)
    klass.name.downcase.pluralize
  end
end
