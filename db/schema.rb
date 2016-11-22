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

ActiveRecord::Schema.define(version: 20161122063112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.integer  "earth"
    t.integer  "wind"
    t.integer  "fire"
    t.string   "special"
    t.text     "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_cards_users_on_card_id", using: :btree
    t.index ["user_id"], name: "index_cards_users_on_user_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer  "challenger_id"
    t.integer  "challenger_card1"
    t.integer  "challenger_card2"
    t.integer  "challenger_card3"
    t.integer  "opponent_id"
    t.integer  "opponent_card1"
    t.integer  "opponent_card2"
    t.integer  "opponent_card3"
    t.integer  "game1_win_by"
    t.integer  "game2_win_by"
    t.integer  "game3_win_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_matches_on_user_id", using: :btree
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "card_count"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stats_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.text     "password_digest"
    t.string   "username"
    t.boolean  "logged_in"
    t.boolean  "in_game"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "cards_users", "cards"
  add_foreign_key "cards_users", "users"
  add_foreign_key "matches", "users"
  add_foreign_key "stats", "users"
end
