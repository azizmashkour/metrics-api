# frozen_string_literal: true
class MetricSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :timestamp, :value, :key
end
