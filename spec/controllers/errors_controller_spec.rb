require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'NOT FOUND' do
    before do
      get :not_found
    end

    it { is_expected.to respond_with(404) }
    it { is_expected.to render_template(:not_found) }
  end
end
