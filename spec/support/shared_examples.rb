require 'rails_helper'

RSpec.shared_examples 'index examples' do
  it { is_expected.to respond_with(200) }
  it { is_expected.to render_template(:index) }
end

RSpec.shared_examples '302 redirects' do
  it { is_expected.to respond_with(302) }
end

RSpec.shared_examples 'not found' do
  it { is_expected.to render_template(:not_found) }
  it { is_expected.to respond_with(404) }
end

RSpec.shared_examples 'validations' do |*fields|
  fields.each do |field|
    it { should validate_presence_of(field) }
  end
end

RSpec.shared_examples 'uniqueness' do |*fields|
  fields.each do |field|
    it { should validate_uniqueness_of(field) }
  end
end

RSpec.shared_examples 'associations' do |*tables|
  tables.each do |table|
    it { is_expected.to belong_to(table) }
  end
end
