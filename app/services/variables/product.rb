# frozen_string_literal: true

module Variables
  class Product < Variables::Base
    def variables
      %w[id name key active? description width length height weight size_unit weight_unit]
    end

    delegate :id, :key, :active?, to: :record

    def name
      product_version_translator&.translate(:name)
    end

    def description
      product_version_translator&.translate(:description)
    end

    def width
      record.product_version&.width
    end

    def length
      record.product_version&.length
    end

    def height
      record.product_version&.height
    end

    def weight
      record.product_version&.weight
    end

    def size_unit
      record.product_version&.size_unit
    end

    def weight_unit
      record.product_version&.weight_unit
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end

    def product_version
      Variables::VariableProvider.new(record: based_on_service.product_version)
    end

    private

    def product_version_translator
      return unless record.product_version

      @_product_version_translator ||= Translations::Translator.new(record: record.product_version, locale: I18n.locale)
    end
  end
end
