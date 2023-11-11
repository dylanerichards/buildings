class Building < ApplicationRecord
  belongs_to :client
  has_many :custom_fields
end
