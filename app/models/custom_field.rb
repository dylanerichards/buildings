class CustomField < ApplicationRecord
  belongs_to :building

  validate :number_field
  validate :enum_field
  validate :field_name

  def number_field
    if field_type == "number"
      if !Float(value, exception: false)
        errors.add(:base, "Value must be a decimal when for field type 'number")
      end
    end
  end

  def enum_field
    if field_type == "enum"
      valid_values = enum_options.split(",")

      if valid_values.exclude?(value)
        errors.add(:base, "Value must be one of '#{valid_values}")
      end
    end
  end
end
