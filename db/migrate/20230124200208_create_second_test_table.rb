class CreateSecondTestTable < ActiveRecord::Migration[7.0]
  def change
    create_table :second_test_tables do |t|
      t.string :inputs

      t.timestamps
    end
  end
end
