class CreateMenuListings < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_listings do |t|
      t.belongs_to :menu, null: false, foreign_key: true
      t.belongs_to :menu_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
