# frozen_string_literal: true

module ApplicationHelper
  def page_title(title, &block)
    content_tag(:div, class: 'd-flex justify-content-between px-3 py-2') do
      concat content_tag(:h1, title)
      concat page_controls(&block)
    end
  end

  def page_controls(&block)
    content_tag(:div, class: 'page_controls') do
      concat back_button
      concat capture(&block) if block_given?
    end
  end

  def card_title(title, &block)
    content_tag(:div, class: 'd-flex justify-content-between') do
      concat content_tag(:h2, title)
      concat card_controls(&block) if block_given?
    end
  end

  def card_controls(&block)
    content_tag(:div) do
      concat capture(&block) if block_given?
    end
  end

  def formatted_unit(value, unit)
    return if value.blank?

    "#{number_with_delimiter(value)} #{unit}"
  end
end
