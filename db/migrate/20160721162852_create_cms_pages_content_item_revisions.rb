class CreateCmsPagesContentItemRevisions < ActiveRecord::Migration
  def change
    create_table :cms_pages_content_item_revisions do |t|
      t.references :cms_page, index: true, foreign_key: true
      t.references :content_item_revision, foreign_key: true

      t.timestamps null: false
    end

    add_index :cms_pages_content_item_revisions, ["content_item_revision_id"], :unique => false, :name => 'shorter_index'
  end
end
