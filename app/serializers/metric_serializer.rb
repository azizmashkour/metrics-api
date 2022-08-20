# frozen_string_literal: true
class MetricSerializer < ApplicationSerializer
  attributes :name, :timestamp, :value, :key
end
