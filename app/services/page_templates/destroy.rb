# frozen_string_literal: true

module PageTemplates
  class Destroy < ApplicationService
    attr_writer :page_template, :fingerprint

    validates :page_template, :fingerprint, presence: true

    validate if: :page_template do
      errors.add(:base, :invalid_status) unless page_template.draft?
    end

    protected

    def perform
      page_template.page_template_changes.destroy_all
      page_template.page_template_changes.reload
      page_template.destroy!
    end
  end
end
