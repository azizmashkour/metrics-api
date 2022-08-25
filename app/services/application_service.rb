# frozen_string_literal: true
# FIXME: all services should inherit from this.
class ApplicationService
  def self.call(*args)
    new(*args).call
  end
end