class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :make
      t.string "name"
      t.string "description"
      t.string "image"
      t.date "launch_date"
      t.boolean "metered", :default => true
      t.boolean "active", :default => true
      t.timestamps
    end
    add_index("models", "make_id")
  end
end
