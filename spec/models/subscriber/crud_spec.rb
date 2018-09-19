# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  let(:subscriber) { create(:subscriber) }

  it 'token is not empty after create' do
    expect(subscriber.token).not_to be_nil
  end
end
