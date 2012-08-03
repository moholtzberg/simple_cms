class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :subject
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => true
      t.string "permalink"
      t.timestamps
    end
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end
end
