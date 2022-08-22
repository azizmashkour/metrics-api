# frozen_string_literal: true

class Metric < ApplicationRecord
  validates :name, :value, :timestamp, presence: true

  KEY_REGEX = /\A[a-zA-Z0-9:_]+\z/.freeze

  GITHUB_PR_DELAYED_KEY = 'pull_requests:delayed'
  GITHUB_PR_UPDATED_KEY = 'pull_requests:updated'
  GITHUB_PR_CLOSED_KEY = 'pull_requests:closed'
  GITHUB_PR_DRAFTED_KEY = 'pull_requests:drafted'
  GITHUB_PR_PENDING_KEY = 'pull_requests:pending'
  GITHUB_PR_MERGED_KEY = 'pull_requests:merged'
  GITHUB_PR_OPENED_KEY = 'pull_requests:opened'
  GITHUB_PR_DEPLOYED_KEY = 'pull_requests:deployed'

  validates :key,
            format: {
              with: KEY_REGEX,
              message: 'may only contain alphanumeric, underscore(_), and colon(:) characters'
            }

  # contain hashes with default attributes for the `official` metrics
  DEFAULT_ATTRIBUTES = {
    GITHUB_PR_DELAYED_KEY => {
      name: "GitHub PR delayed",
      value: 3,
      timestamp: '2022-07-21 11:17:22.181723'
    },
    GITHUB_PR_OPENED_KEY => {
      name: "GitHub PR opened",
      value: 125,
      timestamp: '2022-01-01 18:07:22.181723'
    }, 
    GITHUB_PR_UPDATED_KEY => { 
      name: "GitHub PR updated",
      value: 45,
      timestamp: '2022-09-20 18:07:22.181723'
    },
    GITHUB_PR_CLOSED_KEY => { 
      name: "GitHub PR closed",
      value: 37,
      timestamp: '2022-03-21 18:06:22.181723'
    }, 
    GITHUB_PR_DRAFTED_KEY => { 
      name: "GitHub PR drafted",
      value: 12,
      timestamp: '2022-01-10 18:17:22.181723'
    }, 
    GITHUB_PR_PENDING_KEY => { 
      name: "GitHub PR pending",
      value: 7,
      timestamp: '2022-06-17 08:07:22.181723'
    }, 
    GITHUB_PR_MERGED_KEY => { 
      name: "GitHub PR merged",
      value: 33,
      timestamp: '2022-10-20 10:07:22.181723'
    }, 
    GITHUB_PR_DEPLOYED_KEY => { 
      name: "GitHub PR deployed",
      value: 14,
      timestamp: '2022-10-22 11:07:22.181723'
    }
  }.freeze

  class << self
    def update_or_create(attributes)
      assign_or_new(attributes).save
    end

    def assign_or_new(attributes)
      obj = first || new
      obj.assign_attributes(attributes)
      obj
    end

    def total_metrics_count
      return 0 unless metrics.count.size.positive?
      metrics.count
    end
  end
end

# == Schema Information
#
# Table name: Metrics
#
#  id           :bigint           not null, primary key
#  name         :string
#  key          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  timestamp    :datetime         not null
#  value        :bigint           not null
#