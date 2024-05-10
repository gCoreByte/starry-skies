# frozen_string_literal: true

module PageTemplateStatuses
  class Base < ApplicationService
    attr_accessor :page_template, :fingerprint

    validates :page_template, :fingerprint, presence: true

    validate if: :page_template do
      errors.add(:base, :invalid_status) unless from_statuses.include?(page_template.status)
    end

    def page_template_change
      @_page_template_change ||= PageTemplateChange.new(
        page_template: page_template,
        store: page_template.store,
        status: status,
        content: page_template.content,
        key: page_template.key,
        created_by: fingerprint
      )
    end

    def valid_status?
      from_statuses.include?(page_template.status)
    end

    protected

    def perform
      page_template_change.save!
      page_template.update!(status: status, updated_by: fingerprint)
    end
  end
end
