require 'rails_helper'

RSpec.describe 'Metrics', type: :request do
  describe 'GET /api/v1/metrics.json' do
    before do
      FactoryBot.create_list(:metric, 10)
      get '/api/v1/metrics.json'
    end
    
    it 'returns all metrics' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end