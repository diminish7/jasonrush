# frozen_string_literal: true

RSpec.describe 'Home', type: :request do
  describe 'GET /index' do
    it 'is successful' do
      get root_path

      expect(response).to be_successful
    end
  end
end
