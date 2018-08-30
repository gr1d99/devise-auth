require 'rails_helper'
require_relative '../../app/lib/utils'

RSpec.describe AppUtils do
  let(:klass) { User }

  it 'pluralizes any class name' do
    expected = described_class.pluralize_klass(klass)
    expect(expected).to eq('users')
  end

  it 'raises an exception if argument does not have method name' do
    expect { described_class.pluralize_klass(1) }.to raise_error(NoMethodError)
    expect { described_class.pluralize_klass("some class") }.to raise_error(NoMethodError)
  end
end
