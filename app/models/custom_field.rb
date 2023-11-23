# frozen_string_literal: true

class CustomField < ApplicationRecord
  belongs_to :building

  validate :number_field
  validate :enum_field
  validate :field_name

  def number_field
    return unless field_type == 'number'
    return if Float(value, exception: false)

    errors.add(:base, "Value must be a decimal when for field type 'number")
  end

  def enum_field
    return unless field_type == 'enum'

    errors.add(:base, "Comma-separated enum_options must be present for 'enum' type") if enum_options.empty?

    valid_values = enum_options.split(',').map(&:strip)

    return unless valid_values.exclude?(value)

    errors.add(:base, "Value must be one of '#{valid_values}")
  end
end
