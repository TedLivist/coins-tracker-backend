class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.string :coin_id
      t.decimal :quantity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
