class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.text :item_explanation, null: false
      t.integer :item_status_id, null: false
      t.integer :category_id, null: false
      t.integer :delivery_fee_burden_id, null: false
      t.integer :prefectures_id, null: false
      t.integer :day_to_ship_id, null: false
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true 
      t.timestamps
    end
  end
end
