# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::MetricsController do
  describe '#index' do
    subject { get :index }

    it { is_expected.to be_successful }
      it 'returns valid JSON' do
        body = JSON.parse(subject.body)
        expect(body['metrics'].length).to eq(1)
      end
  end

  describe 'create' do
    let(:metric_params) { { name: 'Tiktok post created' } }

    subject { post :create, params: { metric: metric_params } }

    context 'with valid params' do
      let(:metric_params) { { name: 'Tiktok post created', key: 'tiktok_post:created', value: 100, timestamp: Time.now } }

      it { is_expected.to be_created }

      it 'creates a metric' do
        expect { subject }.to change(Metric, :count).by(1)
      end
    end

    context 'with invalid params' do
      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end