# frozen_string_literal: true

module Variables
  class ProductVersion < Variables::Base
    def variables
      %w[id name description width length height weight size_unit weight_unit]
    end

    delegate :id, :key, :active?, :width, :length, :height, :weight, :size_unit, :weight_unit, to: :record

    def name
      product_version_translator&.translate(:name)
    end

    def description
      product_version_translator&.translate(:description)
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end

    def product
      Variables::VariableProvider.new(record: based_on_service.product)
    end

    def product_price
      Variables::VariableProvider.new(record: based_on_service.product_price)
    end

    private

    def product_version_translator
      return unless record

      @_product_version_translator ||= Translations::Translator.new(record: record, locale: I18n.locale)
    end
  end
end
