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

ActiveRecord::Schema.define(version: 20160308105920) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "title"
    t.string   "location"
    t.string   "cost"
    t.text     "detail"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_applies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "isagree"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_followed_id"
    t.integer  "user_follow_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "group_applies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "isagree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_invites", force: :cascade do |t|
    t.integer  "user_invite_id"
    t.integer  "user_invited_id"
    t.boolean  "isagree"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.text     "introduction"
    t.string   "headimg"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uestc_account"
    t.boolean  "isverify"
    t.string   "nickname"
    t.boolean  "sex"
    t.text     "introduction"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "avatar"
  end

end
