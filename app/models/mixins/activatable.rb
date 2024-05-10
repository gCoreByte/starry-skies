# frozen_string_literal: true

module Mixins
  module Activatable
    extend ActiveSupport::Concern

    included do
      belongs_to :activated_by, class_name: 'Fingerprint', optional: true
      belongs_to :deactivated_by, class_name: 'Fingerprint', optional: true

      scope :active, -> { where.not(activated_at: nil).where(deactivated_at: nil) }

      validates :activated_at, presence: true, if: :activated_by
      validates :activated_by, presence: true, if: :activated_at
      validates :deactivated_at, presence: true, if: :deactivated_by
      validates :deactivated_by, presence: true, if: :deactivated_at
    end

    def active?
      activated_at.present? && deactivated_at.blank?
    end

    def draft?
      activated_at.blank?
    end

    def deactivated?
      deactivated_at.present?
    end

    def activate!(fingerprint, time = Time.zone.now)
      update(activated_at: time, activated_by: fingerprint)
    end

    def deactivate!(fingerprint, time = Time.zone.now)
      update(deactivated_at: time, deactivated_by: fingerprint)
    end
  end
end
