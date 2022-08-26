# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MetricSerializer, type: :serializer do
  subject do
    ActiveModelSerializers::Adapter.create(metric_serializer)
  end

  describe "includes the expected attributes" do
    it do
      expect(subject.serializer.to_hash[:data][:attributes].keys).
        to contain_exactly(
          :name,
          :timestamp,
          :value,
          :key
        )
    end
  end

  describe 'returns correct hash when serializable_hash is called' do
    it do
      options = {}
      serializable_hash = ActiveModelSerializers::Adapter.create(metric_serializer).serializer.serializable_hash
      
      expect(serializable_hash[:data]).to be_instance_of(Hash)
      p serializable_hash[:data].length
      expect(serializable_hash[:data].length).to eq 3
      expect(serializable_hash[:data][:attributes].length).to eq 4

      expect(serializable_hash[:data][:attributes][:name]).to be_instance_of(String)
      expect(serializable_hash[:data][:attributes][:key]).to be_instance_of(String)
      expect(serializable_hash[:data][:attributes][:value]).to be_instance_of(Integer)
      # TODO: this is not working. Find a way to fix it perhaps?
      # expect(serializable_hash[:data][:attributes][:timestamp]).to be_instance_of(Time)
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