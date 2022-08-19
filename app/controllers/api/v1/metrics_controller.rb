# frozen_string_literal: true
#
# Security: Protect from Forgery.
#
module Api
  module V1
    class MetricsController < ApplicationController
      protect_from_forgery with: :null_session
      def index
        metrics = Metric.all

        render json: MetricSerializer.new(metrics).serialized_json
      end

      def create
        metric = Metric.new(metric_params)

        if metric.save
          render json: MetricSerializer.new(metric).serialized_json
        else
          render json: { error: metric.errors.messages }, status: 422
        end
      end

      private

      def metric_params
        params.require(:metric).permit(:name, :value, :timestamp, :key)
      end
    end
  end
end