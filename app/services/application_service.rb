# frozen_string_literal: true

class ApplicationService
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Mixins::ValidateModel

  # FIXME: Reimplement features properly
  # attr_writer :fingerprint # Calling user

  # validate do
  #   errors.add(:base, :missing_feature) unless store.features.intersect?(features)
  # end

  # def features
  #   %w[base]
  # end

  def save
    save!
    performed?
  # FIXME: Implement Sentry
  rescue ActiveRecord::RecordInvalid => _e
    if errors.blank?
      raise if Rails.env.local?

      errors.add(:base, :unknown)
    end
    false
  end

  def save!
    raise ActiveRecord::RecordInvalid, self unless valid?

    before_save
    ApplicationRecord.transaction do
      ApplicationRecord.connection.add_transaction_record(self)
      perform
    end
  end

  # Begin commit callbacks called from ActiveRecord
  def committed!(*)
    after_commit
  end

  def before_committed!(*)
    before_commit
  end

  def rolledback!(*)
    after_rollback
  end

  def trigger_transactional_callbacks?
    true
  end

  # End commit callbacks called from ActiveRecord

  protected

  def performed?
    true
  end

  def before_validation
  end

  def after_validation
  end

  def before_save
  end

  def perform
  end

  def before_commit
  end

  def after_commit
  end

  def after_rollback
  end

  private

  def run_validations!
    before_validation
    super
    after_validation
    errors.empty?
  end
end
