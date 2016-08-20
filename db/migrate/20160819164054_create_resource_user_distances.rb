class CreateResourceUserDistances < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_user_distances do |t|
      t.integer :resource_id, null: false
      t.integer :user_id, null: false
      t.integer :distance, default: 50

      t.timestamps
    end
  end
end
