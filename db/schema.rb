ActiveRecord::Schema.define(version: 2018_08_24_101610) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "positions", force: :cascade do |t|
    t.float "x"
    t.float "y"
    t.float "z"
    t.integer "sound_id"
    t.index ["sound_id"], name: "index_positions_on_sound_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sounds", force: :cascade do |t|
    t.string "s_name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_sounds_on_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "token"
    t.float "range", default: 200.0
    t.float "range_get", default: 50.0
    t.integer "u_type", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end