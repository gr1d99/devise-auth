# frozen_string_literal: true

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'confirmation context', shared_context: :metadata do
  let(:valid_subscriber) { create(:subscriber) }
  let(:confirmed_subscriber) { create(:subscriber, is_confirmed: true) }
  let(:invalid_token) { SecureRandom.urlsafe_base64(nil, true) }
  let(:valid_token) { valid_subscriber.token }
  let(:used_token) { confirmed_subscriber.token }
end

RSpec.configure do |config|
  config.include_context 'confirmation context', include_shared: true
end
