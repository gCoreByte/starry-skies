# frozen_string_literal: true

module Translations
  class Translator
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_accessor :record, :locale

    validates :record, :locale, presence: true
    validate if: :record do
      errors.add(:base, :untranslatable) unless record.respond_to?(:translations)
    end

    validate if: :locale do
      errors.add(:base, :unsupported_locale) unless I18n.available_locales.include?(locale.to_sym)
    end

    def translate(key)
      locale_translations[key.to_s]
    end

    private

    def locale_translations
      @_locale_translations ||= record.translations[locale.to_s] || {}
    end
  end
end
