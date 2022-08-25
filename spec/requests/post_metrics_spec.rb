require 'rails_helper'

RSpec.describe 'Metrics', type: :request do
  let!(:api_url) { '/api/v1/metrics.json' }

  describe 'POST /metrics.json' do
    context 'with valid parameters' do
      let!(:my_metric) { FactoryBot.create(:metric) }

      before do
        post api_url, params:
                          { metric: {
                            name: my_metric.name,
                            value: my_metric.value,
                            timestamp: my_metric.timestamp
                          } }
      end

      it 'returns the name' do
        expect(json['name']).to eq(my_metric.name)
      end

      it 'returns the value' do
        expect(json['value']).to eq(my_metric.value)
      end

      # FIXME: the timezone is not correct. Need to fix before merging.
      it 'returns the timestamp' do
        expect(Time.new(json['timestamp'])).to eq(my_metric.timestamp.utc)
        # p Time.new(json['timestamp']).utc
        # p my_metric.timestamp.utc
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    # FIXME: this scenario returns a `:ok` status.
    # Make sure it's `unprocessable_entity` instead.
    context 'with invalid parameters' do
      before do
        post api_url, params:
                          { metric: {
                            name: '',
                            value: '',
                            timestamp: ''
                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end