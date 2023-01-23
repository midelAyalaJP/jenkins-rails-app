class CreateConcepts < ActiveRecord::Migration[7.0]
  def change
    create_table :concepts do |t|
      t.string :spanish_description
      t.string :english_description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
