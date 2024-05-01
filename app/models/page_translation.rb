# frozen_string_literal: true

class PageTranslation < ApplicationRecord
  belongs_to :page_template
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'

  nullify_and_strip_attributes :content

  validates :content, :locale, presence: true
  validates :content, length: { maximum: 100_000 }, allow_nil: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }, allow_nil: true
  validates :locale, uniqueness: { scope: %i[page_template_id] }
end
