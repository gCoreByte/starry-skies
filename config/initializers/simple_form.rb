# frozen_string_literal: true

HORIZONTAL_FORM_CONFIG = {
  boolean: :horizontal_boolean,
  check_boxes: :horizontal_collection,
  date: :horizontal_multi_select_inline,
  datetime: :horizontal_multi_select_inline,
  file: :horizontal_file,
  radio_buttons: :horizontal_collection,
  time: :horizontal_multi_select_inline,
  default: :horizontal_form
}.freeze

VERTICAL_FORM_CONFIG = {
  boolean: :vertical_boolean,
  check_boxes: :vertical_collection,
  date: :vertical_multi_select_inline,
  datetime: :vertical_multi_select_inline,
  file: :vertical_file,
  radio_buttons: :vertical_collection,
  range: :vertical_range,
  time: :vertical_multi_select_inline,
  default: :vertical_form
}.freeze

INLINE_FORM_CONFIG = {
  boolean: :inline_boolean,
  default: :inline_form
}.freeze

FLOATING_FORM_CONFIG = {
  date: :floating_labels_select,
  datetime: :floating_labels_select,
  time: :floating_labels_select,
  default: :floating_labels_form
}.freeze

# Use this setup block to configure all options available in SimpleForm.
module SimpleForm
  class FormBuilder

    map_type :json, :jsonb, to: JsonInput

    alias_method :super_find_wrapper_mapping, :find_wrapper_mapping

    def find_wrapper_mapping(input_type)
      super_find_wrapper_mapping(input_type) || begin
        options[:wrapper_mappings] && options[:wrapper_mappings][:default]
      end
    end

    def horizontal_fields_for(record_name, record_object = nil, options = {}, &block)
      simple_fields_for(record_name, record_object, options.merge(wrapper_mappings: HORIZONTAL_FORM_CONFIG), &block)
    end

    def vertical_fields_for(record_name, record_object = nil, options = {}, &block)
      simple_fields_for(record_name, record_object, options.merge(wrapper_mappings: VERTICAL_FORM_CONFIG), &block)
    end

  end
end

SimpleForm.setup do |config| # rubocop:disable Metrics/BlockLength
  # The default wrapper to be used by the FormBuilder.

  config.wrapper_mappings = VERTICAL_FORM_CONFIG
  config.default_wrapper = config.wrapper_mappings[:default]

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :inline

  # Default class for buttons
  config.button_class = 'btn btn-default'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  config.error_method = :to_sentence

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert alert-danger'

  # add validation classes to `input_field`
  config.input_field_error_class = 'is-invalid'
  # config.input_field_valid_class = 'is-valid'

  # ID to add for error notification helper.
  # config.error_notification_id = nil

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span.
  config.item_wrapper_tag = :div

  # You can define a class to use in all item wrappers. Defaulting to none.
  # config.item_wrapper_class = nil

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the default class to be used on forms. Can be overriden
  # with `html: { :class }`. Defaulting to none.
  # config.default_form_class = nil

  # You can define which elements should obtain additional classes
  # config.generate_additional_classes_for = [:wrapper, :label, :input]

  # Whether attributes are required by default (or not). Default is true.
  config.required_by_default = false

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = true

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :mounted_as, :file?, :public_filename ]

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  config.input_mappings = { /_count\z/ => :integer }

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = { string: :prepend }

  # Namespaces where SimpleForm should look for custom input classes that
  # override default inputs.
  # config.custom_inputs_namespaces << "CustomInputs"

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # When false, do not use translations for labels.
  # config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache SimpleForm inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for inputs
  # config.input_class = nil

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'form-check-label'

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  # config.include_default_input_wrapper_class = true
  config.include_default_input_wrapper_class = false

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'

  # ******************** Vertical form ********************

  config.wrappers :vertical_form,
                  tag: 'div',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_boolean,
                  tag: 'fieldset',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'form-check' do |bb|
      bb.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
      bb.use :label, class: 'form-check-label'
      bb.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :vertical_collection,
                  item_wrapper_class: 'form-check', tag: 'fieldset',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_collection_inline,
                  item_wrapper_class: 'form-check form-check-inline', tag: 'fieldset',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_file,
                  tag: 'div',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control-file', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_multi_select,
                  tag: 'div',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |ba|
      ba.use :input, class: 'form-control mx-1', error_class: 'is-invalid', valid_class: 'is-valid'
    end
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_multi_select_inline,
                  tag: 'div',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper tag: 'div', class: 'form-inline' do |ba|
      ba.use :input, class: 'form-control mr-2', error_class: 'is-invalid', valid_class: 'is-valid'
    end
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_range,
                  tag: 'div',
                  class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label
    b.use :input, class: 'form-control-range', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # ******************** Horizontal form ********************

  config.wrappers :horizontal_form,
                  tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_boolean,
                  tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: 'label', class: 'col-sm-3' do |ba|
      ba.use :label_text
    end
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |wr|
      wr.wrapper :form_check_wrapper, tag: 'div', class: 'form-check' do |bb|
        bb.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
        bb.use :label, class: 'form-check-label'
        bb.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
        bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
      end
    end
  end

  config.wrappers :horizontal_collection,
                  item_wrapper_class: 'form-check', tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_collection_inline,
                  item_wrapper_class: 'form-check form-check-inline', tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_file,
                  tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_multi_select,
                  tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |bb|
        bb.use :input, class: 'form-control mx-1', error_class: 'is-invalid', valid_class: 'is-valid'
      end
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_multi_select_inline,
                  tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.wrapper tag: 'div', class: 'form-inline' do |bb|
        bb.use :input, class: 'form-control mr-2', error_class: 'is-invalid', valid_class: 'is-valid'
      end
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_range,
                  tag: 'div',
                  class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: 'col-sm-3 form-control-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control-range', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # ******************** Inline form ********************

  config.wrappers :inline_form,
                  tag: 'span',
                  error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :inline_boolean,
                  tag: 'span',
                  class: 'form-check flex-wrap justify-content-start mr-sm-2',
                  error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label, class: 'form-check-label'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # ******************** Floating form ********************

  config.wrappers :floating_labels_form,
                  tag: 'div',
                  class: 'form-label-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label, class: 'form-control-label'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :floating_labels_select,
                  tag: 'div',
                  class: 'form-label-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'custom-select custom-select-lg', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label, class: 'form-control-label'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end
end
