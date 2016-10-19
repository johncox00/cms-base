class CreateChangeSets < ActiveRecord::Migration
  def change
    create_table :change_sets do |t|
      t.integer :created_by
      t.datetime :active_at
      t.datetime :inactive_at

      t.timestamps null: false
    end
  end
end
