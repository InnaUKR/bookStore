ActiveRecord::Schema.define(version: 20180213134036) do

  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "price", precision: 8, scale: 2
    t.integer "quantity", null: false
    t.text "description"
    t.date "year", null: false
    t.string "material", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "height", precision: 5, scale: 2
    t.decimal "width", precision: 5, scale: 2
    t.decimal "depth", precision: 5, scale: 2
  end

end
