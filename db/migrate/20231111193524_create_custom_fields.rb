class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.references :building, foreign_key: true
      t.string :name
      t.string :value
      t.string :type

      t.timestamps
    end
  end
end
