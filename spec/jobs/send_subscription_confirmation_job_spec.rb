require 'rails_helper'

RSpec.describe SendSubscriptionConfirmationJob, type: :job do
  let(:email) { Faker::Internet.email }
  let(:confirmation_url) { Faker::Internet.url }
  let(:notification_params) {
    { email: email,
      confirmation_url: confirmation_url }
  }

  it 'enqueues SendSubscriptionConfirmationJob job' do
    expect {
      described_class.perform_later(notification_params)
    }.to have_enqueued_job(described_class)
  end

  it 'matches passed arguments' do
    expect {
      described_class.perform_later(notification_params)
    }.to have_enqueued_job.with(notification_params)
  end

  it 'matches enqueued job time' do
    expect {
      described_class.set(
        wait_until: Date.tomorrow.noon
      ).perform_later(notification_params)
    }.to have_enqueued_job.at(Date.tomorrow.noon)
  end

  it 'calls on subscription mailer' do
    perform_enqueued_jobs do
      described_class.perform_later(notification_params)
    end

    expect(last_email.to).to eq([email])
    expect(last_email.body.encoded).to include(confirmation_url)
    expect(last_email.from).to eq([ENV['DEFAULT_SUBSCRIPTION_MAILER_FROM']])
  end
end
