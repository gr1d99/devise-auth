require 'rails_helper'

RSpec.shared_examples 'index examples' do |assigned_resource, klass|
  it { is_expected.to respond_with(200) }
  it { is_expected.to render_template(:index) }
  it "assigns #{assigned_resource}" do
    expect(assigns(assigned_resource)).to match_array(klass.all)
  end
end

RSpec.shared_examples 'not found' do
  it { is_expected.to render_template(:not_found) }
  it { is_expected.to respond_with(404) }
end
