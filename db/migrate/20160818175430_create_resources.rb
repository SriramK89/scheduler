class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.integer :pair_resource_id
      t.boolean :has_vcon, default: false

      t.timestamps
    end
  end
end
