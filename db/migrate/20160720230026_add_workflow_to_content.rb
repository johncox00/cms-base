class AddWorkflowToContent < ActiveRecord::Migration
  def change
    add_column :content_item_revisions, :workflow_state, :string
    add_column :change_sets, :workflow_state, :string, default: 'new'
  end
end
