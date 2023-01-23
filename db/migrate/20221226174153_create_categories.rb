class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :spanish_description
      t.string :english_description

      t.timestamps
    end
  end
end
