class ChangePageContentRelation < ActiveRecord::Migration
  def up
    drop_table :cms_pages_content_item_revisions
    create_table :cms_pages_content_items do |t|
      t.references :cms_page, index: true, foreign_key: true
      t.references :content_item, foreign_key: true

      t.timestamps null: false
    end

    add_index :cms_pages_content_items, ["content_item_id"], :unique => false, :name => 'shorter_index'
  end
  def down
    drop_table :cms_pages_content_items
    create_table :cms_pages_content_item_revisions do |t|
      t.references :cms_page, index: true, foreign_key: true
      t.references :content_item_revision, foreign_key: true

      t.timestamps null: false
    end

    add_index :cms_pages_content_item_revisions, ["content_item_revision_id"], :unique => false, :name => 'shorter_index'
  end
end
