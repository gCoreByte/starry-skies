# frozen_string_literal: true

module PageTranslations
  class Destroy < ApplicationService
    attr_writer :page_translation, :fingerprint

    validates :page_translation, :fingerprint, presence: true

    protected

    def perform
      page_translation.destroy!
    end
  end
end
