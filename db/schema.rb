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

ActiveRecord::Schema.define(version: 20140501182532) do

  create_table "bet_item_clones", force: true do |t|
    t.integer  "bet_item_id"
    t.float    "odds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id"
  end

  create_table "bet_items", force: true do |t|
    t.string   "name"
    t.string   "odds"
    t.integer  "bet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: false
  end

  add_index "bet_items", ["bet_id"], name: "index_bet_items_on_bet_id", using: :btree

  create_table "bet_types", force: true do |t|
    t.string "name"
  end

  create_table "bets", force: true do |t|
    t.string   "name"
    t.integer  "bet_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
    t.integer  "event_id"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "league_id"
    t.boolean  "active",     default: false
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "result"
  end

  add_index "events", ["name"], name: "index_events_on_name", using: :btree

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
    t.integer  "sport_id"
  end

  create_table "results", force: true do |t|
    t.string   "title"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sports", ["name"], name: "index_sports_on_name", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.datetime "date"
    t.integer  "status"
    t.float    "stake"
    t.float    "payout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",        default: -1
    t.integer  "scratchcard_id", default: -1
    t.float    "odds"
    t.integer  "printed"
  end

  create_table "transactions", force: true do |t|
    t.float    "amount"
    t.integer  "transaction_type"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "role_id"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: true
  end

end
