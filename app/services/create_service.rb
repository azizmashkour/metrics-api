# frozen_string_literal: true

# Metric create service
class CreateService < ApplicationService
  def initialize(args)
  end

  def self.perform(metric_params)
    metric = Metric.new(metric_params)

    return nil unless metric.save!

    metric
  rescue StandardError => e
    Rails.logger.error(e)
  end
end
