# frozen_string_literal: true

class ProductVersion < ApplicationRecord
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

  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  belongs_to :store
  belongs_to :product

  # FIXME: Move to mixin
  scope :active, -> { where.not(activated_at: nil).where(deactivated_at: nil) }

  validates :version, presence: true
  validates :version, numericality: { minimum: 0, maximum: 999 }, allow_nil: true
  validates :version, uniqueness: { scope: :product_id }
  validates :description, length: { maximum: 1000 }, allow_nil: true

  validates :width, :length, :height, :weight,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 50_000 }, allow_nil: true
  validates :size_unit, inclusion: { in: SizeUnits::ALL }, allow_nil: true
  validates :weight_unit, inclusion: { in: WeightUnits::ALL }, allow_nil: true

  # FIXME: Add validation to disallow unit without values

  def set_version
    return unless product

    self.version = product.product_versions.maximum(:version).to_i + 1
  end
end
