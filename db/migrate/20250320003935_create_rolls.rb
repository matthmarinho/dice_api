class CreateRolls < ActiveRecord::Migration[8.0]
  def change
    create_table :rolls do |t|
      t.string :expression
      t.integer :result

      t.timestamps
    end
  end
end
