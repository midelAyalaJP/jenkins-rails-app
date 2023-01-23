class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :spanish_description
      t.text :english_description
      t.integer :unit
      t.decimal :price_mxn
      t.references :concept, null: false, foreign_key: true

      t.timestamps
    end
  end
end
