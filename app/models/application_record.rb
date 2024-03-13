# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def validate_record_store(record)
    raise 'Store mismatch' if record.store_id != store_id
  end
end
