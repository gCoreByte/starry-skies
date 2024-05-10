# frozen_string_literal: true

module ProductVersions
  class Translations < ApplicationService
    attr_writer :payload
    attr_accessor :product_version, :fingerprint

    validates :product_version, :fingerprint, presence: true

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      add_translations
      product_version.update!(translations: new_translation)
    end

    private

    def add_translations
      payload.each_key do |locale|
        payload[locale].each_key do |key|
          next unless ProductVersion::TRANSLATABLE_KEYS.include?(key)

          new_translation[locale] ||= {}
          new_translation[locale][key] = payload.dig(locale, key)
        end
      end
    end

    def new_translation
      @_new_translation ||= product_version.translations || {}
    end
  end
end
