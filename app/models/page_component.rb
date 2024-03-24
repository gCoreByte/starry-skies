# frozen_string_literal: true

class PageComponent < ApplicationRecord
  # FIXME: Implement properly
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  validates :content, :based_on, presence: true
  validates :based_on, inclusion: { in: BasedOns::BasedOn.possible_based_ons }, allow_nil: true
end
