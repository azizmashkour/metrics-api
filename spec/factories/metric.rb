# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    name { 'Twitter DM sent' }
    key { 'twitter_dm:sent' }
    value { 156 }
    timestamp { Time.now }
  end
end
