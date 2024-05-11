# frozen_string_literal: true

class BlogPostTranslation < ApplicationRecord
  belongs_to :blog_post
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  nullify_and_strip_attributes :title, :content

  validates :title, :content, :locale, presence: true
  validates :content, length: { maximum: 100_000 }, allow_nil: true
  validates :title, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }, allow_nil: true
  validates :locale, uniqueness: { scope: %i[blog_post_id] }
end
