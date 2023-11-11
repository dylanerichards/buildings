class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.references :building, foreign_key: true
      t.string :field_name
      t.string :value
      t.string :field_type

      t.timestamps
    end
  end
end
