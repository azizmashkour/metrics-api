# frozen_string_literal: true

# Metric create service
class CreateService < ApplicationService
  def initialize(args)
  end

  def self.perform(metric_params)
    metric = Metric.new(metric_params)

    throw ActiveRecord::RecordInvalid unless metric.save!

    metric
  end
end
