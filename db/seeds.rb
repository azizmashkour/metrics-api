# frozen_string_literal: true

Metric
  .where(key: Metric::GITHUB_PR_DELAYED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_DELAYED_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_OPENED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_OPENED_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_UPDATED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_UPDATED_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_CLOSED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_CLOSED_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_DRAFTED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_DRAFTED_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_PENDING_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_PENDING_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_MERGED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_MERGED_KEY]
  )

Metric
  .where(key: Metric::GITHUB_PR_DEPLOYED_KEY)
  .update_or_create(
    Metric::DEFAULT_ATTRIBUTES[Metric::GITHUB_PR_DEPLOYED_KEY]
  )