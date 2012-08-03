class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visable", :default => true
      t.timestamps
    end
  end
end
