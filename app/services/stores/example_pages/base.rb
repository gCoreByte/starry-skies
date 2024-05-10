# frozen_string_literal: true

module Stores
  module ExamplePages
    class Base
      attr_accessor :store, :fingerprint

      def initialize(store:, fingerprint:)
        @store = store
        @fingerprint = fingerprint
      end

      def records
        [page_template, page, *page_translations]
      end

      def page_template
        @_page_template ||= PageTemplate.new(
          store: store,
          created_by: fingerprint,
          updated_by: fingerprint,
          key: key,
          based_on: based_on,
          status: PageTemplate::Statuses::ACTIVE
        )
      end

      def page_translations
        @_page_translations ||= [
          build_page_translation('en', english_content),
          build_page_translation('et', estonian_content),
          build_page_translation('ru', russian_content)
        ].compact
      end

      def page
        @_page ||= Page.new(
          store: store,
          page_template: page_template,
          created_by: fingerprint,
          updated_by: fingerprint,
          key: key,
          status: Page::Statuses::LIVE,
          url: key
        )
      end

      private

      def build_page_translation(locale, content)
        return unless content

        PageTranslation.new(
          page_template: page_template,
          store: store,
          created_by: fingerprint,
          locale: locale,
          content: content
        )
      end
    end
  end
end
