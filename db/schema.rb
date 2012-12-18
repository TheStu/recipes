# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121217213035) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "category_joins", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "days", :force => true do |t|
    t.integer  "meal_plan_id"
    t.integer  "day_number"
    t.string   "day_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "days", ["meal_plan_id"], :name => "index_days_on_meal_plan_id"

  create_table "ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "merchant_name"
    t.string   "product_name"
    t.string   "retail_price"
    t.string   "sale_price"
    t.string   "thumbnail_image"
    t.string   "buy_url"
    t.string   "abbreviated_description"
    t.string   "link_type"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "sidebar",                 :default => false
  end

  create_table "meal_plans", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "meal_plans", ["user_id"], :name => "index_meal_plans_on_user_id"

  create_table "meals", :force => true do |t|
    t.integer  "day_id"
    t.integer  "recipe_id"
    t.string   "recipe_title"
    t.string   "specific_meal"
    t.integer  "base_calories"
    t.integer  "servings_made"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "meals", ["day_id"], :name => "index_meals_on_day_id"
  add_index "meals", ["recipe_id"], :name => "index_meals_on_recipe_id"

  create_table "people", :force => true do |t|
    t.integer  "meal_plan_id"
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.integer  "weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "people", ["meal_plan_id"], :name => "index_people_on_meal_plan_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "recipes", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "introduction"
    t.text     "preperation"
    t.integer  "cooking_time"
    t.string   "equipment"
    t.integer  "servings"
    t.string   "picture"
    t.integer  "weight",        :default => 0
    t.integer  "calories",      :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "pots"
    t.decimal  "average_stars", :default => 0.0
  end

  add_index "recipes", ["calories"], :name => "index_recipes_on_calories"
  add_index "recipes", ["cooking_time"], :name => "index_recipes_on_cooking_time"
  add_index "recipes", ["pots"], :name => "index_recipes_on_pots"
  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"
  add_index "recipes", ["weight"], :name => "index_recipes_on_weight"

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.text     "content"
    t.integer  "stars"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
    t.string   "trailname"
    t.string   "location"
    t.text     "bio"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
