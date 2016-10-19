class CreateContentItemRevisions < ActiveRecord::Migration
  def change
    create_table :content_item_revisions do |t|
      t.text :content
      t.references :content_item_revision, index: true, foreign_key: true
      t.integer :created_by
      t.integer :last_modified_by
      t.references :change_set, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
