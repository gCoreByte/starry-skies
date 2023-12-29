# frozen_string_literal: true

class ProductVersion < ApplicationRecord
  belongs_to :created_by, class_name: 'AdminAccount'

  belongs_to :product
end
