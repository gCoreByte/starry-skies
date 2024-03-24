# frozen_string_literal: true

module PageStatuses
  class Base < ApplicationService
    attr_accessor :page, :fingerprint

    validates :page, :fingerprint, presence: true

    validate if: :page do
      errors.add(:base, :invalid_status) unless from_statuses.include?(page.status)
    end

    def valid_status?
      from_statuses.include?(page.status)
    end

    protected

    def perform
      page.update!(status: status, updated_by: fingerprint)
    end
  end
end
