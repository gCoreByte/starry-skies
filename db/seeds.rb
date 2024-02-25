# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless AdminAccount.find_by(email: 'admin@corebyte.ee')
  AdminAccount.new(
    email: 'admin@corebyte.ee', name: 'CoreByte', password: 'password', password_confirmation: 'password'
  ).save!
end

# Packages
Package.find_or_create_by!(name: 'Basic', key: 'basic', price: 0.0, features: [Features::BASE])
Package.find_or_create_by!(name: 'Advanced', key: 'advanced', price: 10.0, features: [Features::BASE])
Package.find_or_create_by!(name: 'Pro', key: 'pro', price: 20.0, features: Features::ALL)
