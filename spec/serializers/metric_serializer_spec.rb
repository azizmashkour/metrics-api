# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MetricSerializer, type: :serializer do
  subject do
    ActiveModelSerializers::Adapter.create(metric_serializer)
  end

  describe "includes the expected attributes" do
    it do
      subject_json(subject)
      expect(subject_json(subject).attributes.keys).
        to contain_exactly(
          :name,
          :key,
          :value,
          :timestamp
        )
    end
  end

  describe 'returns correct hash when serializable_hash is called' do
    it do
      options = {}
      serializable_hash = ActiveModelSerializers::Adapter.create(metric_serializer).serializable_hash
      
      expect(serializable_hash[:data]).to be_instance_of(Hash)
      
      expect(serializable_hash[:data].length).to eq 1
      expect(serializable_hash[:data][0][:attributes].length).to eq 4

      expect(serializable_hash[:data][0][:attributes][:name]).to be_instance_of(Hash)
    end
  end

  def metric_resource
    FactoryBot.build(:metric)
  end

  # Create an instance of the serializer
  def metric_serializer
    MetricSerializer.new(metric_resource)
  end
end