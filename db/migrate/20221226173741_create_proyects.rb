class CreateProyects < ActiveRecord::Migration[7.0]
  def change
    create_table :proyects do |t|
      t.string :name
      t.integer :client_id
      t.string :contact
      t.string :country
      t.string :state
      t.string :address

      t.timestamps
    end
  end
end
