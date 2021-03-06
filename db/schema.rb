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

ActiveRecord::Schema.define(version: 20150626020952) do

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "status",      limit: 4,   default: 0,           null: false
    t.string   "hidden_word", limit: 255,                       null: false
    t.string   "username",    limit: 255, default: "anonymous"
    t.integer  "lives",       limit: 4
  end

  create_table "guesses", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "game_id",    limit: 4
    t.string   "letter",     limit: 255, null: false
  end

  add_index "guesses", ["game_id"], name: "index_guesses_on_game_id", using: :btree

  add_foreign_key "guesses", "games"
end
