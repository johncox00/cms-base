class AddContentItemIdToContentItemRevisions < ActiveRecord::Migration
  def change
    add_column :content_item_revisions, :content_item_id, :integer
  end
end
