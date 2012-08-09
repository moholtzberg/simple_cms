class CreateMeters < ActiveRecord::Migration
  def change
    create_table :meters do |t|
      t.references :model
      t.boolean "is_color"
      t.integer "max_duty_cycle"
      t.integer "rec_duty_cycle"
      t.timestamps
    end
    add_index("meters", "model_id")
  end
end
