# frozen_string_literal: true

module Pages
  class Destroy < ApplicationService
    attr_accessor :page, :fingerprint

    validates :page, :fingerprint, presence: true

    validate if: :page do
      errors.add(:base, :invalid_status) unless page.draft?
    end

    protected

    def perform
      page.destroy!
    end
  end
end
