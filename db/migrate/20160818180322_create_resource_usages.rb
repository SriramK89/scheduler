class CreateResourceUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_usages do |t|
      t.integer :resource_id, null: false
      t.integer :user_id, null: false
      t.boolean :require_vcon, default: false
      t.boolean :require_min_distance, default: false
      t.boolean :require_double_resource, default: false
      t.integer :from_time, null: false
      t.integer :to_time, null: false

      t.timestamps
    end
  end
end
