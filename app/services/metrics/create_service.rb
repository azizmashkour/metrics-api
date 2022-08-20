# frozen_string_literal: true

module Metric
  # Metric create service
  class CreateService
    class << self
      def perform(metric_params)
        metric = Metric.new(metric_params)

        return nil unless metric.save!

        metric
      rescue StandardError => e
        Rails.logger.error(e)
      end
    end
  end
end
