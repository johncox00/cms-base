class AddIdentifierToContentItemRevisions < ActiveRecord::Migration
  def change
    add_column :content_item_revisions, :identifier, :string
  end
end
