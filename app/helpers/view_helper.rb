# frozen_string_literal: true

module ViewHelper
  def time_tag(time, format: :default)
    return unless time

    tag.time(
      I18n.l(time, format: format),
      datetime: time.iso8601,
      data: { format: time_format(time, format), time: !time.is_a?(Date) }
    )
  end

  # Copied from i18n/backend/base.rb #localize
  def time_format(time, format)
    return format unless format.is_a?(Symbol)

    key = format
    type = time.respond_to?(:sec) ? 'time' : 'date'
    I18n.t(:"#{type}.formats.#{key}", raise: true, object: time, locale: I18n.locale)
  end
end
