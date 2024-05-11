# frozen_string_literal: true

class BlogPost < ApplicationRecord
  nullify_and_strip_attributes :key

  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  has_many :blog_post_translations, dependent: :destroy

  validates :key, presence: true
  validates :key, uniqueness: { scope: :store_id }
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true

  def translation_for(locale)
    blog_post_translations.find_by(locale: locale) || blog_post_translations.first
  end

  def content
    translation_for(I18n.locale)&.content
  end

  def title
    translation_for(I18n.locale)&.title
  end

  def markdown_content
    MARKDOWN_RENDERER.render(content)
  rescue StandardError
    content
  end
end
