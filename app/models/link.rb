class Link < ActiveRecord::Base
  attr_accessible :abbreviated_description, :buy_url, :link_type, :merchant_name, :product_name,
  :retail_price, :sale_price, :thumbnail_image, :sidebar
end
