class CreateContentItems < ActiveRecord::Migration
  def change
    create_table :content_items do |t|
      t.string :identifier
      t.integer :container_id
      t.string :description

      t.timestamps null: false
    end
  end
end
