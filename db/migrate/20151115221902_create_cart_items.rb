class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
