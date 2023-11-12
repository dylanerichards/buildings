class CustomField < ApplicationRecord
  belongs_to :building

  validate :number_field

  def number_field
    if field_type == "number"
      if !Float(value, exception: false)
        errors.add(:base, "Value must be a decimal when for field type 'number")
      end
    end
  end
end
