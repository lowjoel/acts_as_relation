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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 4) do

  create_table "pencils", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pens", force: true do |t|
    t.integer  "as_pen_id"
    t.string   "as_pen_type"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pens", ["as_pen_id", "as_pen_type"], name: "pens_as_pen_index"

  create_table "products", force: true do |t|
    t.integer  "producible_id"
    t.string   "producible_type"
    t.string   "name"
    t.float    "price"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["producible_id", "producible_type"], name: "products_producible_index"

  create_table "stores", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
