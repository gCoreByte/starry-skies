# frozen_string_literal: true

RSpec::Matchers.define :have_errors_on do |attribute|
  match do |model|
    @model = model
    @attribute = attribute || raise(ArgumentError, 'Attribute missing')
    @model.errors.include?(@attribute) && error_details_matches && error_message_matches
  end

  chain :with_message do |message, options|
    @message = message
    @message_options = options
  end

  chain :with_details do |details|
    @details = a_hash_including(details)
  end

  failure_message do
    errors = []
    errors << 'be invalid' if @model.errors.blank?
    errors << "have errors on #{@attribute}" if @model.errors[@attribute].blank?
    errors << "have #{@message} error on #{@attribute}" unless error_message_matches
    errors << "have #{@details} error on #{@attribute}" unless error_details_matches

    <<~MSG
      Expected #{@model} #{errors.join(' and ')}

      The record had following errors:
        #{@model.errors[@attribute].inspect}
    MSG
  end

  failure_message_when_negated do
    <<~MSG
      Expected #{@model} not to have errors on #{@attribute}

      The record had following errors:
        #{@model.errors[@attribute].inspect}
    MSG
  end

  private

  def error_details_matches
    return true if @details.nil?

    expect(@model.errors.details[@attribute]).to include(@details)
  end

  def error_message_matches
    return true if @message.nil?

    @model.errors[@attribute].include?(error_message)
  end

  def error_message
    @model.errors.generate_message(@attribute, @message, @message_options || {})
  end
end
