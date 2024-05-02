# frozen_string_literal: true

class ProductVersion < ApplicationRecord
  include Mixins::Activatable
  include Mixins::Translatable

  TRANSLATABLE_KEYS = %w[name description].freeze

  module SizeUnits
    MM = 'mm'
    CM = 'cm'
    M = 'm'
    ALL = [MM, CM, M].freeze
  end

  module WeightUnits
    G = 'g'
    KG = 'kg'
    ALL = [G, KG].freeze
  end

  nullify_attributes :width, :length, :height, :weight, :size_unit, :weight_unit

  has_many :product_version_categories, dependent: nil
  has_many :product_categories, through: :product_version_categories
  has_many :product_prices, dependent: nil
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  belongs_to :store
  belongs_to :product

  validates :version, presence: true
  validates :version, numericality: { minimum: 0, maximum: 999 }, allow_nil: true
  validates :version, uniqueness: { scope: :product_id }

  validates :width, :length, :height, :weight,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 50_000 }, allow_nil: true
  validates :size_unit, inclusion: { in: SizeUnits::ALL }, allow_nil: true
  validates :weight_unit, inclusion: { in: WeightUnits::ALL }, allow_nil: true

  validate if: %i[store product] do
    validate_record_store(product)
  end

  # FIXME: Add validation to disallow unit without values

  def title
    "V#{version}"
  end

  def available_categories
    store.product_categories.where.not(id: product_categories.pluck(:id))
  end

  def product_price
    user_group_price || product_prices.first
  end

  def name
    translation_service.translate_with_locale(:name, I18n.locale)
  end

  def description
    translation_service.translate_with_locale(:description, I18n.locale)
  end

  private

  def user_group_price
    user_groups = Current.user_account&.user_groups
    product_prices.joins(:user_group).where(user_groups: { id: user_groups }).order(ranking: :asc).first
  end

  def translation_service
    @_translation_service ||= Translations::Translator.new(record: self, locale: I18n.locale)
  end
end
