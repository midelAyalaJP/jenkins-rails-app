class CreateContractors < ActiveRecord::Migration[7.0]
  def change
    create_table :contractors do |t|
      t.string :name
      t.string :phone
      t.string :job

      t.timestamps
    end
  end
end
