class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :merchant_name
      t.string :product_name
      t.string :retail_price
      t.string :sale_price
      t.string :thumbnail_image
      t.string :buy_url
      t.string :abbreviated_description
      t.string :link_type

      t.timestamps
    end
  end
end
