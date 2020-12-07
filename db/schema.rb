# frozen_string_literal: true
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_207_153_828) do

  create_table 'active_storage_attachments', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'cart_items', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name'
    t.integer 'value'
    t.bigint 'cart_id', null: false
    t.bigint 'product_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['cart_id'], name: 'index_cart_items_on_cart_id'
    t.index ['product_id'], name: 'index_cart_items_on_product_id'
  end

  create_table 'carts', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'discounts', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'price_discount', default: 0
    t.integer 'p_number', default: 0
    t.integer 'd_number', default: 0
    t.boolean 'p_switch', default: false
    t.boolean 'd_switch', default: false
    t.integer 'quota', default: 0
    t.integer 'free_delivery_quota', default: 0
    t.bigint 'user_id'
    t.bigint 'order_id'
    t.bigint 'product_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['order_id'], name: 'index_discounts_on_order_id'
    t.index ['product_id'], name: 'index_discounts_on_product_id'
    t.index ['user_id'], name: 'index_discounts_on_user_id'
  end

  create_table 'fav_products', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'product_id', null: false
    t.string 'note'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['product_id'], name: 'index_fav_products_on_product_id'
    t.index ['user_id'], name: 'index_fav_products_on_user_id'
  end

  create_table 'items', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name'
    t.string 'value'
    t.bigint 'product_id', null: false
    t.bigint 'order_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['order_id'], name: 'index_items_on_order_id'
    t.index ['product_id'], name: 'index_items_on_product_id'
  end

  create_table 'orders', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name'
    t.integer 'number'
    t.string 'code'
    t.integer 'price'
    t.integer 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'delivery', default: 0
    t.string 'email'
  end

  create_table 'products', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name'
    t.string 'sku'
    t.integer 'market_price'
    t.integer 'original_price'
    t.integer 'number'
    t.integer 'status', default: 0
    t.integer 'user_id'
    t.boolean 'remember', default: false
    t.boolean 'boolean', default: false
    t.boolean 'gift', default: false
    t.integer 'quantity_discount', default: 0
    t.boolean 'q_switch', default: false
    t.integer 'quantity', default: 0
    t.integer 'q_number', default: 0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'note'
  end

  create_table 'stocks', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'value'
    t.bigint 'product_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['product_id'], name: 'index_stocks_on_product_id'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'username'
    t.string 'name'
    t.string 'website'
    t.text 'bio'
    t.string 'phone'
    t.integer 'gender'
    t.integer 'wallet', default: 2_000_000
    t.boolean 'discount_sw', default: false
    t.integer 'number', default: 0
    t.integer 'discount_price', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'cart_items', 'carts'
  add_foreign_key 'cart_items', 'products'
  add_foreign_key 'carts', 'users'
  add_foreign_key 'fav_products', 'products'
  add_foreign_key 'fav_products', 'users'
  add_foreign_key 'items', 'orders'
  add_foreign_key 'items', 'products'
  add_foreign_key 'stocks', 'products'
end
