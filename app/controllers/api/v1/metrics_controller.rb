# frozen_string_literal: true
#
# Security: Protect from Forgery.
#
module Api
  module V1
    class MetricsController < ApplicationController
      protect_from_forgery with: :null_session
      
      def index
        build_metrics(Metric.all)
      end

      def create
        build_metrics(
          CreateService.perform(metric_params)
        )
      end

      private

      def build_metrics(args)
        json_response(args, serializer: MetricSerializer)
      end

      def metric_params
        params.require(:metric).permit(:name, :value, :timestamp, :key)
      end
    end
  end
end