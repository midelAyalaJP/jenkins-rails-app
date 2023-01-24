class TestCreateTestsTable < ActiveRecord::Migration[7.0]
    def change
        create_table :tests_table do |t|
            t.string :item, null: false
            
            t.timestamps
        end
        add_index :tests_table, :jti
    end
end
